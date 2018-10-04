KEYCODE = {
    [0x00] = 0,
    [0x01] = "ERROR_ROLL_OVER",
    [0x02] = "POST_FAIL",
    [0x03] = "ERROR_UNDEFINED",
    [0x04] = "A",
    [0x05] = "B",
    [0x06] = "C",
    [0x07] = "D",
    [0x08] = "E",
    [0x09] = "F",
    [0x0A] = "G",
    [0x0B] = "H",
    [0x0C] = "I",
    [0x0D] = "J",
    [0x0E] = "K",
    [0x0F] = "L",
    [0x10] = "M",
    [0x11] = "N",
    [0x12] = "O",
    [0x13] = "P",
    [0x14] = "Q",
    [0x15] = "R",
    [0x16] = "S",
    [0x17] = "T",
    [0x18] = "U",
    [0x19] = "V",
    [0x1A] = "W",
    [0x1B] = "X",
    [0x1C] = "Y",
    [0x1D] = "Z",
}


-- Create Protocol
proto = Proto("In_USB", "Interrupt-in_USB protocol")

-- Create Fields
local fields = proto.fields

fields.InputData = ProtoField.uint8("proto.data", "IN", base.HEX, KEYCODE)

function proto.dissector(buffer, pinfo, tree)
    pinfo.cols.protocol = proto.name

    local subtree = tree:add(proto, buffer(), "DATA")

    for i = 0, buffer:len()-1 do
        subtree:add(fields.InputData, buffer(i, 1))
    end
end

usb_table = DissectorTable.get("usb.interrupt")
usb_table:add(0xff, proto)
usb_table:add(0xffff, proto)
