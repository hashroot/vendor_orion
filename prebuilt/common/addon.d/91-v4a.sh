#!/sbin/sh
# 
# /system/addon.d/91-v4a.sh
# This script backs up /system/lib/soundfx/libv4a_fx_ics.so, etc/audio_effects.conf, and vendor/etc/audio_effects.conf
# /system is formatted and reinstalled, then the file is restored.
#

. /tmp/backuptool.functions

list_files() {
cat <<EOF
lib/soundfx/libv4a_fx_ics.so
etc/audio_effects.conf
priv-app/Viper4Android/Viper4Android.apk
su.d/15v4a.sh
vendor/etc/audio_effects.conf
EOF
}

case "$1" in
  backup)
    list_files | while read FILE DUMMY; do
      backup_file $S/"$FILE"
    done
  ;;
  restore)
    list_files | while read FILE REPLACEMENT; do
      R=""
      [ -n "$REPLACEMENT" ] && R="$S/$REPLACEMENT"
      [ -f "$C/$S/$FILE" ] && restore_file $S/"$FILE" "$R"
    done
		rm /system/priv-app/AudioFX.apk
		rm /system/priv-app/AudioFX/AudioFX.apk
		rm /system/app/DSPManager.apk
		rm /system/app/DSPManager/DSPManager.apk
		rm /system/priv-app/MusicFX.apk
		rm /system/priv-app/MusicFX/MusicFX.apk
  ;;
  pre-backup)
    # Stub
  ;;
  post-backup)
    # Stub
  ;;
  pre-restore)
    mkdir /system/su.d
  ;;
  post-restore)
	# audio_policy.conf edits for V4A compatibility
	sed -i '/deep_buffer {/,/}/s/^/#/' /system/etc/audio_policy.conf
  ;;
esac
