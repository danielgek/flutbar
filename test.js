'use strict';

const constants = {
    MAGIC_STRING: "i3-ipc",
    TYPES: {
        COMMAND: 0,
        GET_WORKSPACES: 1,
        SUBSCRIBE: 2,
        GET_OUTPUTS: 3,
        GET_TREE: 4,
        GET_MARKS: 5,
        GET_BAR_CONFIG: 6
    },
    EVENTS: {
        WORKSPACE: 0,
        OUTPUT: 1
    }
}
const utils = {
    packInt: function packInt() {
        console.log(arguments)
        var args = Array.prototype.slice.call(arguments);
        console.log(args)
        var result = '';
        args.forEach(function (e) {
            console.log(String.fromCharCode(e & 0xFF));
            console.log(String.fromCharCode(e >> 8 & 0xFF));
            console.log(String.fromCharCode(e >> 16 & 0xFF));
            console.log(String.fromCharCode(e >> 24 & 0xFF));

            
            result += String.fromCharCode(e & 0xFF);
            result += String.fromCharCode(e >> 8 & 0xFF);
            result += String.fromCharCode(e >> 16 & 0xFF);
            result += String.fromCharCode(e >> 24 & 0xFF);
        });
        return result;
    },

    unpackInt: function unpackInt(str) {
        var b1 = str.charCodeAt(0) & 0xFF;
        var b2 = str.charCodeAt(1) & 0xFF;
        var b3 = str.charCodeAt(2) & 0xFF;
        var b4 = str.charCodeAt(3) & 0xFF;

        return (((((b4 << 8) + b3) << 8) + b2) << 8) + b1;
    }
}

function format(type, payload) {
    const size = payload ? payload.length : 0;
    let msg = constants.MAGIC_STRING;
    msg += utils.packInt(size, type);
    if (payload)
        msg += payload;
    return msg;
}

function parse(data) {
    if (data.slice(0, constants.MAGIC_STRING.length).toString() != constants.MAGIC_STRING) {
        return { error: 'wrong magic code' };
    }

    var size = utils.unpackInt(data.slice(constants.MAGIC_STRING.length, constants.MAGIC_STRING.length + 4).toString());
    var type = utils.unpackInt(data.slice(constants.MAGIC_STRING.length + 4, constants.MAGIC_STRING.length + 8).toString());

    /**
     * Everything after `size` is discarded.
     * Maybe re-enqueue the left-over data;
     * this way the whole communication could work
     * without queueing the messages internally.
    **/
    var answer = data.slice(constants.MAGIC_STRING.length + 8, data.length);


    var json = {};
    json.data = JSON.parse(answer.toString());
    json.size = size;

    /**
     * got an event? high bit is set!
     * the implemantation of unpackInt
     * seems a little bit wrong;
     * should return 1 here, right?
     **/
    if ((type >> 31) == -1) {
        json.event = true;
        type = type & 0x7f;
    }
    json.type = type;

    return json;
}
const net = require('net');
const unixClient = net.createConnection(process.env.I3SOCK);
console.log('format' + format(constants.TYPES.GET_WORKSPACES))

unixClient.write(format(constants.TYPES.GET_WORKSPACES))


unixClient.on('connection', (s) => {
    unixClient.write(format(constants.TYPES.GET_WORKSPACES))
    console.log('got connection!', s);
    // s.write('i3-ipc' + Buffer.from('1').toString());
    // s.end();
});


unixClient.on('data', (s) => {
    console.log('got data!', parse(s));
    // s.write('i3-ipc' + Buffer.from('1').toString());
    // s.end();
});