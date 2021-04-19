pa_sink=$(pactl load-module module-null-sink sink_name="game_sink" sink_properties=device.description="game_audio")
pa_loop=$(pactl load-module module-loopback source=game_sink.monitor sink=alsa_output.usb-FiiO_DigiHug_USB_Audio-01.analog-stereo rate=44100)

echo -e "${pa_sink}\n${pa_loop}" > .game_sinks
