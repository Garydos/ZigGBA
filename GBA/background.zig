const GBA = @import("core.zig").GBA;

pub const Background = struct {
    pub const BackgroundControl = packed struct {
        priority: u2 = 0,
        characterBaseBlock: u2 = 0,
        dummy: u2 = 0,
        mosaic: u1 = 0,
        paletteMode: GBA.PaletteMode = .Color16,
        screenBaseBlock: u5 = 0,
        dummy2: u1 = 0,
        screenSize: packed enum(u2) {
            Text32x32,
            Text64x32,
            Text32x64,
            Text64x64,
        } = .Text32x32,
    };

    pub const Background0Control = @intToPtr(*volatile BackgroundControl, 0x4000008);
    pub const Background1Control = @intToPtr(*volatile BackgroundControl, 0x400000A);
    pub const Background2Control = @intToPtr(*volatile BackgroundControl, 0x400000C);
    pub const Background3Control = @intToPtr(*volatile BackgroundControl, 0x400000E);

    pub inline fn setupBackground(background: *volatile BackgroundControl, settings: BackgroundControl) void {
        background.* = settings;
    }

    pub const Scroll = packed struct {
        x: u9,
        dummy: u7,
        y: u9,
        dummy2: u7,

        const Self = @This();

        pub inline fn setPosition(self: *volatile Self, x: i32, y: i32) void {
            @setRuntimeSafety(false);
            const Mask = (1 << 9) - 1;
            self.x = @intCast(u9, x & Mask);
            self.y = @intCast(u9, y & Mask);
        }
    };

    pub const Background0Scroll = @intToPtr(*volatile Scroll, 0x4000010);
    pub const Background1Scroll = @intToPtr(*volatile Scroll, 0x4000014);
    pub const Background2Scroll = @intToPtr(*volatile Scroll, 0x4000018);
    pub const Background3Scroll = @intToPtr(*volatile Scroll, 0x400001C);

    pub const TextScreenEntry = packed struct {
        tileIndex: u10,
        horizontalFlip: u1,
        verticalFlip: u1,
        paletteIndex: u4,
    };

    pub const AffineScreenEntry = packed struct {
        tileIndex: u8,
    };
};
