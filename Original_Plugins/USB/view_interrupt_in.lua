KEYCODE = {
    [0x0000] = 0,
    [0x0100] = "ERROR_ROLL_OVER",
    [0x0200] = "POST_FAIL",
    [0x0300] = "ERROR_UNDEFINED",
    [0x0400] = "A",
    [0x0500] = "B",
    [0x0600] = "C",
    [0x0700] = "D",
    [0x0800] = "E",
    [0x0900] = "F",
    [0x0A00] = "G",
    [0x0B00] = "H",
    [0x0C00] = "I",
    [0x0D00] = "J",
    [0x0E00] = "K",
    [0x0F00] = "L",
    [0x1000] = "M",
    [0x1100] = "N",
    [0x1200] = "O",
    [0x1300] = "P",
    [0x1400] = "Q",
    [0x1500] = "R",
    [0x1600] = "S",
    [0x1700] = "T",
    [0x1800] = "U",
    [0x1900] = "V",
    [0x1A00] = "W",
    [0x1B00] = "X",
    [0x1C00] = "Y",
    [0x1D00] = "Z",
}


-- プロトコルの作成
proto = Proto("In_USB", "Interrupt-in_USB protocol")

-- fieldsの作成
local fields = proto.fields

-- フィールドの設定
fields.InputData = ProtoField.uint16("proto.data", "IN", base.HEX, KEYCODE) 


function proto.dissector(buffer, pinfo, tree)
    pinfo.cols.protocol = proto.name


    -- local data = ByteArray.new(proto)

    local subtree = tree:add(proto, buffer(), "DATA")
    subtree:add(fields.InputData, buffer())
end



-- プロトコルの追加・関連付け
usb_table = DissectorTable.get("usb.interrupt")
usb_table:add(0xff, proto)
usb_table:add(0xffff, proto)
