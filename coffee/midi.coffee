console.log "this the midi shit"

window.connectMidi = (device, midiMap) ->

    onMIDIFailure = (err) ->
        console.log "FAILED TO CONNECT MIDI", err

    onMIDIMessage = (ev) ->
        dispatch = [ev.data[0], ev.data[1]]
        if dispatch of midiMap
            midiMap[dispatch]()
        else
            console.log "UNKNOWN MESSAGE: ", dispatch

    onMIDISuccess = (midi) ->
        window.midi = midi
        console.log "CONNCETED TO MIDI, YAH!"

        listDevices = (devices, lookFor=undefined) ->
            for d, i in devices
                console.log """
                    MIDI port (#{i}) +
                        type: #{d.type}
                        id: #{d.type}
                        name: #{d.name}
                        manufacturer: #{d.manufacturer}
                """

        console.log "--- inputs --------"
        listDevices midi.inputs()
        console.log "--- outputs -------"
        listDevices midi.outputs()

        input  = _.find midi.inputs(), (x) -> x.name.indexOf(device) != -1
        output = _.find midi.outputs(), (x) -> x.name.indexOf(device) != -1

        console.log "FOUND DEVICE", input, output
        input.onmidimessage = onMIDIMessage

    navigator
        .requestMIDIAccess()
        .then onMIDISuccess, onMIDIFailure
