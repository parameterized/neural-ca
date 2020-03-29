
uniform Image xin;
uniform Image h;
uniform Image dense2;
uniform vec2 randOffset;

float rand(vec2 p)
{
	return fract(sin(dot(p, vec2(12.9898, 4.1414))) * 43758.5453);
}

vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords)
{
    vec3 d = vec3(-1.0, 0.0, 1.0);
    vec2 cs = vec2(64.0);
    vec2 uv = mod(screen_coords.xy, cs);
    float ci = floor(screen_coords.x / cs.x);
    vec2 xss = vec2(64.0 * 4.0, 64.0);
    vec2 hss = vec2(64.0 * 32.0, 64.0);
    vec2 dss = vec2(129.0, 4.0);

vec4 h0 = max(Texel(h, vec2(uv.x + 0.0 * cs.x, uv.y) / hss), 0.0);
vec4 h1 = max(Texel(h, vec2(uv.x + 1.0 * cs.x, uv.y) / hss), 0.0);
vec4 h2 = max(Texel(h, vec2(uv.x + 2.0 * cs.x, uv.y) / hss), 0.0);
vec4 h3 = max(Texel(h, vec2(uv.x + 3.0 * cs.x, uv.y) / hss), 0.0);
vec4 h4 = max(Texel(h, vec2(uv.x + 4.0 * cs.x, uv.y) / hss), 0.0);
vec4 h5 = max(Texel(h, vec2(uv.x + 5.0 * cs.x, uv.y) / hss), 0.0);
vec4 h6 = max(Texel(h, vec2(uv.x + 6.0 * cs.x, uv.y) / hss), 0.0);
vec4 h7 = max(Texel(h, vec2(uv.x + 7.0 * cs.x, uv.y) / hss), 0.0);
vec4 h8 = max(Texel(h, vec2(uv.x + 8.0 * cs.x, uv.y) / hss), 0.0);
vec4 h9 = max(Texel(h, vec2(uv.x + 9.0 * cs.x, uv.y) / hss), 0.0);
vec4 h10 = max(Texel(h, vec2(uv.x + 10.0 * cs.x, uv.y) / hss), 0.0);
vec4 h11 = max(Texel(h, vec2(uv.x + 11.0 * cs.x, uv.y) / hss), 0.0);
vec4 h12 = max(Texel(h, vec2(uv.x + 12.0 * cs.x, uv.y) / hss), 0.0);
vec4 h13 = max(Texel(h, vec2(uv.x + 13.0 * cs.x, uv.y) / hss), 0.0);
vec4 h14 = max(Texel(h, vec2(uv.x + 14.0 * cs.x, uv.y) / hss), 0.0);
vec4 h15 = max(Texel(h, vec2(uv.x + 15.0 * cs.x, uv.y) / hss), 0.0);
vec4 h16 = max(Texel(h, vec2(uv.x + 16.0 * cs.x, uv.y) / hss), 0.0);
vec4 h17 = max(Texel(h, vec2(uv.x + 17.0 * cs.x, uv.y) / hss), 0.0);
vec4 h18 = max(Texel(h, vec2(uv.x + 18.0 * cs.x, uv.y) / hss), 0.0);
vec4 h19 = max(Texel(h, vec2(uv.x + 19.0 * cs.x, uv.y) / hss), 0.0);
vec4 h20 = max(Texel(h, vec2(uv.x + 20.0 * cs.x, uv.y) / hss), 0.0);
vec4 h21 = max(Texel(h, vec2(uv.x + 21.0 * cs.x, uv.y) / hss), 0.0);
vec4 h22 = max(Texel(h, vec2(uv.x + 22.0 * cs.x, uv.y) / hss), 0.0);
vec4 h23 = max(Texel(h, vec2(uv.x + 23.0 * cs.x, uv.y) / hss), 0.0);
vec4 h24 = max(Texel(h, vec2(uv.x + 24.0 * cs.x, uv.y) / hss), 0.0);
vec4 h25 = max(Texel(h, vec2(uv.x + 25.0 * cs.x, uv.y) / hss), 0.0);
vec4 h26 = max(Texel(h, vec2(uv.x + 26.0 * cs.x, uv.y) / hss), 0.0);
vec4 h27 = max(Texel(h, vec2(uv.x + 27.0 * cs.x, uv.y) / hss), 0.0);
vec4 h28 = max(Texel(h, vec2(uv.x + 28.0 * cs.x, uv.y) / hss), 0.0);
vec4 h29 = max(Texel(h, vec2(uv.x + 29.0 * cs.x, uv.y) / hss), 0.0);
vec4 h30 = max(Texel(h, vec2(uv.x + 30.0 * cs.x, uv.y) / hss), 0.0);
vec4 h31 = max(Texel(h, vec2(uv.x + 31.0 * cs.x, uv.y) / hss), 0.0);

vec4 d2_0 = Texel(dense2, vec2(0.5, ci + 0.5) / dss);
vec4 d2_1 = Texel(dense2, vec2(1.5, ci + 0.5) / dss);
vec4 d2_2 = Texel(dense2, vec2(2.5, ci + 0.5) / dss);
vec4 d2_3 = Texel(dense2, vec2(3.5, ci + 0.5) / dss);
vec4 d2_4 = Texel(dense2, vec2(4.5, ci + 0.5) / dss);
vec4 d2_5 = Texel(dense2, vec2(5.5, ci + 0.5) / dss);
vec4 d2_6 = Texel(dense2, vec2(6.5, ci + 0.5) / dss);
vec4 d2_7 = Texel(dense2, vec2(7.5, ci + 0.5) / dss);
vec4 d2_8 = Texel(dense2, vec2(8.5, ci + 0.5) / dss);
vec4 d2_9 = Texel(dense2, vec2(9.5, ci + 0.5) / dss);
vec4 d2_10 = Texel(dense2, vec2(10.5, ci + 0.5) / dss);
vec4 d2_11 = Texel(dense2, vec2(11.5, ci + 0.5) / dss);
vec4 d2_12 = Texel(dense2, vec2(12.5, ci + 0.5) / dss);
vec4 d2_13 = Texel(dense2, vec2(13.5, ci + 0.5) / dss);
vec4 d2_14 = Texel(dense2, vec2(14.5, ci + 0.5) / dss);
vec4 d2_15 = Texel(dense2, vec2(15.5, ci + 0.5) / dss);
vec4 d2_16 = Texel(dense2, vec2(16.5, ci + 0.5) / dss);
vec4 d2_17 = Texel(dense2, vec2(17.5, ci + 0.5) / dss);
vec4 d2_18 = Texel(dense2, vec2(18.5, ci + 0.5) / dss);
vec4 d2_19 = Texel(dense2, vec2(19.5, ci + 0.5) / dss);
vec4 d2_20 = Texel(dense2, vec2(20.5, ci + 0.5) / dss);
vec4 d2_21 = Texel(dense2, vec2(21.5, ci + 0.5) / dss);
vec4 d2_22 = Texel(dense2, vec2(22.5, ci + 0.5) / dss);
vec4 d2_23 = Texel(dense2, vec2(23.5, ci + 0.5) / dss);
vec4 d2_24 = Texel(dense2, vec2(24.5, ci + 0.5) / dss);
vec4 d2_25 = Texel(dense2, vec2(25.5, ci + 0.5) / dss);
vec4 d2_26 = Texel(dense2, vec2(26.5, ci + 0.5) / dss);
vec4 d2_27 = Texel(dense2, vec2(27.5, ci + 0.5) / dss);
vec4 d2_28 = Texel(dense2, vec2(28.5, ci + 0.5) / dss);
vec4 d2_29 = Texel(dense2, vec2(29.5, ci + 0.5) / dss);
vec4 d2_30 = Texel(dense2, vec2(30.5, ci + 0.5) / dss);
vec4 d2_31 = Texel(dense2, vec2(31.5, ci + 0.5) / dss);
vec4 d2_32 = Texel(dense2, vec2(32.5, ci + 0.5) / dss);
vec4 d2_33 = Texel(dense2, vec2(33.5, ci + 0.5) / dss);
vec4 d2_34 = Texel(dense2, vec2(34.5, ci + 0.5) / dss);
vec4 d2_35 = Texel(dense2, vec2(35.5, ci + 0.5) / dss);
vec4 d2_36 = Texel(dense2, vec2(36.5, ci + 0.5) / dss);
vec4 d2_37 = Texel(dense2, vec2(37.5, ci + 0.5) / dss);
vec4 d2_38 = Texel(dense2, vec2(38.5, ci + 0.5) / dss);
vec4 d2_39 = Texel(dense2, vec2(39.5, ci + 0.5) / dss);
vec4 d2_40 = Texel(dense2, vec2(40.5, ci + 0.5) / dss);
vec4 d2_41 = Texel(dense2, vec2(41.5, ci + 0.5) / dss);
vec4 d2_42 = Texel(dense2, vec2(42.5, ci + 0.5) / dss);
vec4 d2_43 = Texel(dense2, vec2(43.5, ci + 0.5) / dss);
vec4 d2_44 = Texel(dense2, vec2(44.5, ci + 0.5) / dss);
vec4 d2_45 = Texel(dense2, vec2(45.5, ci + 0.5) / dss);
vec4 d2_46 = Texel(dense2, vec2(46.5, ci + 0.5) / dss);
vec4 d2_47 = Texel(dense2, vec2(47.5, ci + 0.5) / dss);
vec4 d2_48 = Texel(dense2, vec2(48.5, ci + 0.5) / dss);
vec4 d2_49 = Texel(dense2, vec2(49.5, ci + 0.5) / dss);
vec4 d2_50 = Texel(dense2, vec2(50.5, ci + 0.5) / dss);
vec4 d2_51 = Texel(dense2, vec2(51.5, ci + 0.5) / dss);
vec4 d2_52 = Texel(dense2, vec2(52.5, ci + 0.5) / dss);
vec4 d2_53 = Texel(dense2, vec2(53.5, ci + 0.5) / dss);
vec4 d2_54 = Texel(dense2, vec2(54.5, ci + 0.5) / dss);
vec4 d2_55 = Texel(dense2, vec2(55.5, ci + 0.5) / dss);
vec4 d2_56 = Texel(dense2, vec2(56.5, ci + 0.5) / dss);
vec4 d2_57 = Texel(dense2, vec2(57.5, ci + 0.5) / dss);
vec4 d2_58 = Texel(dense2, vec2(58.5, ci + 0.5) / dss);
vec4 d2_59 = Texel(dense2, vec2(59.5, ci + 0.5) / dss);
vec4 d2_60 = Texel(dense2, vec2(60.5, ci + 0.5) / dss);
vec4 d2_61 = Texel(dense2, vec2(61.5, ci + 0.5) / dss);
vec4 d2_62 = Texel(dense2, vec2(62.5, ci + 0.5) / dss);
vec4 d2_63 = Texel(dense2, vec2(63.5, ci + 0.5) / dss);
vec4 d2_64 = Texel(dense2, vec2(64.5, ci + 0.5) / dss);
vec4 d2_65 = Texel(dense2, vec2(65.5, ci + 0.5) / dss);
vec4 d2_66 = Texel(dense2, vec2(66.5, ci + 0.5) / dss);
vec4 d2_67 = Texel(dense2, vec2(67.5, ci + 0.5) / dss);
vec4 d2_68 = Texel(dense2, vec2(68.5, ci + 0.5) / dss);
vec4 d2_69 = Texel(dense2, vec2(69.5, ci + 0.5) / dss);
vec4 d2_70 = Texel(dense2, vec2(70.5, ci + 0.5) / dss);
vec4 d2_71 = Texel(dense2, vec2(71.5, ci + 0.5) / dss);
vec4 d2_72 = Texel(dense2, vec2(72.5, ci + 0.5) / dss);
vec4 d2_73 = Texel(dense2, vec2(73.5, ci + 0.5) / dss);
vec4 d2_74 = Texel(dense2, vec2(74.5, ci + 0.5) / dss);
vec4 d2_75 = Texel(dense2, vec2(75.5, ci + 0.5) / dss);
vec4 d2_76 = Texel(dense2, vec2(76.5, ci + 0.5) / dss);
vec4 d2_77 = Texel(dense2, vec2(77.5, ci + 0.5) / dss);
vec4 d2_78 = Texel(dense2, vec2(78.5, ci + 0.5) / dss);
vec4 d2_79 = Texel(dense2, vec2(79.5, ci + 0.5) / dss);
vec4 d2_80 = Texel(dense2, vec2(80.5, ci + 0.5) / dss);
vec4 d2_81 = Texel(dense2, vec2(81.5, ci + 0.5) / dss);
vec4 d2_82 = Texel(dense2, vec2(82.5, ci + 0.5) / dss);
vec4 d2_83 = Texel(dense2, vec2(83.5, ci + 0.5) / dss);
vec4 d2_84 = Texel(dense2, vec2(84.5, ci + 0.5) / dss);
vec4 d2_85 = Texel(dense2, vec2(85.5, ci + 0.5) / dss);
vec4 d2_86 = Texel(dense2, vec2(86.5, ci + 0.5) / dss);
vec4 d2_87 = Texel(dense2, vec2(87.5, ci + 0.5) / dss);
vec4 d2_88 = Texel(dense2, vec2(88.5, ci + 0.5) / dss);
vec4 d2_89 = Texel(dense2, vec2(89.5, ci + 0.5) / dss);
vec4 d2_90 = Texel(dense2, vec2(90.5, ci + 0.5) / dss);
vec4 d2_91 = Texel(dense2, vec2(91.5, ci + 0.5) / dss);
vec4 d2_92 = Texel(dense2, vec2(92.5, ci + 0.5) / dss);
vec4 d2_93 = Texel(dense2, vec2(93.5, ci + 0.5) / dss);
vec4 d2_94 = Texel(dense2, vec2(94.5, ci + 0.5) / dss);
vec4 d2_95 = Texel(dense2, vec2(95.5, ci + 0.5) / dss);
vec4 d2_96 = Texel(dense2, vec2(96.5, ci + 0.5) / dss);
vec4 d2_97 = Texel(dense2, vec2(97.5, ci + 0.5) / dss);
vec4 d2_98 = Texel(dense2, vec2(98.5, ci + 0.5) / dss);
vec4 d2_99 = Texel(dense2, vec2(99.5, ci + 0.5) / dss);
vec4 d2_100 = Texel(dense2, vec2(100.5, ci + 0.5) / dss);
vec4 d2_101 = Texel(dense2, vec2(101.5, ci + 0.5) / dss);
vec4 d2_102 = Texel(dense2, vec2(102.5, ci + 0.5) / dss);
vec4 d2_103 = Texel(dense2, vec2(103.5, ci + 0.5) / dss);
vec4 d2_104 = Texel(dense2, vec2(104.5, ci + 0.5) / dss);
vec4 d2_105 = Texel(dense2, vec2(105.5, ci + 0.5) / dss);
vec4 d2_106 = Texel(dense2, vec2(106.5, ci + 0.5) / dss);
vec4 d2_107 = Texel(dense2, vec2(107.5, ci + 0.5) / dss);
vec4 d2_108 = Texel(dense2, vec2(108.5, ci + 0.5) / dss);
vec4 d2_109 = Texel(dense2, vec2(109.5, ci + 0.5) / dss);
vec4 d2_110 = Texel(dense2, vec2(110.5, ci + 0.5) / dss);
vec4 d2_111 = Texel(dense2, vec2(111.5, ci + 0.5) / dss);
vec4 d2_112 = Texel(dense2, vec2(112.5, ci + 0.5) / dss);
vec4 d2_113 = Texel(dense2, vec2(113.5, ci + 0.5) / dss);
vec4 d2_114 = Texel(dense2, vec2(114.5, ci + 0.5) / dss);
vec4 d2_115 = Texel(dense2, vec2(115.5, ci + 0.5) / dss);
vec4 d2_116 = Texel(dense2, vec2(116.5, ci + 0.5) / dss);
vec4 d2_117 = Texel(dense2, vec2(117.5, ci + 0.5) / dss);
vec4 d2_118 = Texel(dense2, vec2(118.5, ci + 0.5) / dss);
vec4 d2_119 = Texel(dense2, vec2(119.5, ci + 0.5) / dss);
vec4 d2_120 = Texel(dense2, vec2(120.5, ci + 0.5) / dss);
vec4 d2_121 = Texel(dense2, vec2(121.5, ci + 0.5) / dss);
vec4 d2_122 = Texel(dense2, vec2(122.5, ci + 0.5) / dss);
vec4 d2_123 = Texel(dense2, vec2(123.5, ci + 0.5) / dss);
vec4 d2_124 = Texel(dense2, vec2(124.5, ci + 0.5) / dss);
vec4 d2_125 = Texel(dense2, vec2(125.5, ci + 0.5) / dss);
vec4 d2_126 = Texel(dense2, vec2(126.5, ci + 0.5) / dss);
vec4 d2_127 = Texel(dense2, vec2(127.5, ci + 0.5) / dss);
vec4 d2_128 = Texel(dense2, vec2(128.5, ci + 0.5) / dss);

float y0 = h0.x * d2_0.x + h0.y * d2_1.x + h0.z * d2_2.x + h0.w * d2_3.x + h1.x * d2_4.x + h1.y * d2_5.x + h1.z * d2_6.x + h1.w * d2_7.x + h2.x * d2_8.x + h2.y * d2_9.x + h2.z * d2_10.x + h2.w * d2_11.x + h3.x * d2_12.x + h3.y * d2_13.x + h3.z * d2_14.x + h3.w * d2_15.x + h4.x * d2_16.x + h4.y * d2_17.x + h4.z * d2_18.x + h4.w * d2_19.x + h5.x * d2_20.x + h5.y * d2_21.x + h5.z * d2_22.x + h5.w * d2_23.x + h6.x * d2_24.x + h6.y * d2_25.x + h6.z * d2_26.x + h6.w * d2_27.x + h7.x * d2_28.x + h7.y * d2_29.x + h7.z * d2_30.x + h7.w * d2_31.x + h8.x * d2_32.x + h8.y * d2_33.x + h8.z * d2_34.x + h8.w * d2_35.x + h9.x * d2_36.x + h9.y * d2_37.x + h9.z * d2_38.x + h9.w * d2_39.x + h10.x * d2_40.x + h10.y * d2_41.x + h10.z * d2_42.x + h10.w * d2_43.x + h11.x * d2_44.x + h11.y * d2_45.x + h11.z * d2_46.x + h11.w * d2_47.x + h12.x * d2_48.x + h12.y * d2_49.x + h12.z * d2_50.x + h12.w * d2_51.x + h13.x * d2_52.x + h13.y * d2_53.x + h13.z * d2_54.x + h13.w * d2_55.x + h14.x * d2_56.x + h14.y * d2_57.x + h14.z * d2_58.x + h14.w * d2_59.x + h15.x * d2_60.x + h15.y * d2_61.x + h15.z * d2_62.x + h15.w * d2_63.x + h16.x * d2_64.x + h16.y * d2_65.x + h16.z * d2_66.x + h16.w * d2_67.x + h17.x * d2_68.x + h17.y * d2_69.x + h17.z * d2_70.x + h17.w * d2_71.x + h18.x * d2_72.x + h18.y * d2_73.x + h18.z * d2_74.x + h18.w * d2_75.x + h19.x * d2_76.x + h19.y * d2_77.x + h19.z * d2_78.x + h19.w * d2_79.x + h20.x * d2_80.x + h20.y * d2_81.x + h20.z * d2_82.x + h20.w * d2_83.x + h21.x * d2_84.x + h21.y * d2_85.x + h21.z * d2_86.x + h21.w * d2_87.x + h22.x * d2_88.x + h22.y * d2_89.x + h22.z * d2_90.x + h22.w * d2_91.x + h23.x * d2_92.x + h23.y * d2_93.x + h23.z * d2_94.x + h23.w * d2_95.x + h24.x * d2_96.x + h24.y * d2_97.x + h24.z * d2_98.x + h24.w * d2_99.x + h25.x * d2_100.x + h25.y * d2_101.x + h25.z * d2_102.x + h25.w * d2_103.x + h26.x * d2_104.x + h26.y * d2_105.x + h26.z * d2_106.x + h26.w * d2_107.x + h27.x * d2_108.x + h27.y * d2_109.x + h27.z * d2_110.x + h27.w * d2_111.x + h28.x * d2_112.x + h28.y * d2_113.x + h28.z * d2_114.x + h28.w * d2_115.x + h29.x * d2_116.x + h29.y * d2_117.x + h29.z * d2_118.x + h29.w * d2_119.x + h30.x * d2_120.x + h30.y * d2_121.x + h30.z * d2_122.x + h30.w * d2_123.x + h31.x * d2_124.x + h31.y * d2_125.x + h31.z * d2_126.x + h31.w * d2_127.x + d2_128.x;
float y1 = h0.x * d2_0.y + h0.y * d2_1.y + h0.z * d2_2.y + h0.w * d2_3.y + h1.x * d2_4.y + h1.y * d2_5.y + h1.z * d2_6.y + h1.w * d2_7.y + h2.x * d2_8.y + h2.y * d2_9.y + h2.z * d2_10.y + h2.w * d2_11.y + h3.x * d2_12.y + h3.y * d2_13.y + h3.z * d2_14.y + h3.w * d2_15.y + h4.x * d2_16.y + h4.y * d2_17.y + h4.z * d2_18.y + h4.w * d2_19.y + h5.x * d2_20.y + h5.y * d2_21.y + h5.z * d2_22.y + h5.w * d2_23.y + h6.x * d2_24.y + h6.y * d2_25.y + h6.z * d2_26.y + h6.w * d2_27.y + h7.x * d2_28.y + h7.y * d2_29.y + h7.z * d2_30.y + h7.w * d2_31.y + h8.x * d2_32.y + h8.y * d2_33.y + h8.z * d2_34.y + h8.w * d2_35.y + h9.x * d2_36.y + h9.y * d2_37.y + h9.z * d2_38.y + h9.w * d2_39.y + h10.x * d2_40.y + h10.y * d2_41.y + h10.z * d2_42.y + h10.w * d2_43.y + h11.x * d2_44.y + h11.y * d2_45.y + h11.z * d2_46.y + h11.w * d2_47.y + h12.x * d2_48.y + h12.y * d2_49.y + h12.z * d2_50.y + h12.w * d2_51.y + h13.x * d2_52.y + h13.y * d2_53.y + h13.z * d2_54.y + h13.w * d2_55.y + h14.x * d2_56.y + h14.y * d2_57.y + h14.z * d2_58.y + h14.w * d2_59.y + h15.x * d2_60.y + h15.y * d2_61.y + h15.z * d2_62.y + h15.w * d2_63.y + h16.x * d2_64.y + h16.y * d2_65.y + h16.z * d2_66.y + h16.w * d2_67.y + h17.x * d2_68.y + h17.y * d2_69.y + h17.z * d2_70.y + h17.w * d2_71.y + h18.x * d2_72.y + h18.y * d2_73.y + h18.z * d2_74.y + h18.w * d2_75.y + h19.x * d2_76.y + h19.y * d2_77.y + h19.z * d2_78.y + h19.w * d2_79.y + h20.x * d2_80.y + h20.y * d2_81.y + h20.z * d2_82.y + h20.w * d2_83.y + h21.x * d2_84.y + h21.y * d2_85.y + h21.z * d2_86.y + h21.w * d2_87.y + h22.x * d2_88.y + h22.y * d2_89.y + h22.z * d2_90.y + h22.w * d2_91.y + h23.x * d2_92.y + h23.y * d2_93.y + h23.z * d2_94.y + h23.w * d2_95.y + h24.x * d2_96.y + h24.y * d2_97.y + h24.z * d2_98.y + h24.w * d2_99.y + h25.x * d2_100.y + h25.y * d2_101.y + h25.z * d2_102.y + h25.w * d2_103.y + h26.x * d2_104.y + h26.y * d2_105.y + h26.z * d2_106.y + h26.w * d2_107.y + h27.x * d2_108.y + h27.y * d2_109.y + h27.z * d2_110.y + h27.w * d2_111.y + h28.x * d2_112.y + h28.y * d2_113.y + h28.z * d2_114.y + h28.w * d2_115.y + h29.x * d2_116.y + h29.y * d2_117.y + h29.z * d2_118.y + h29.w * d2_119.y + h30.x * d2_120.y + h30.y * d2_121.y + h30.z * d2_122.y + h30.w * d2_123.y + h31.x * d2_124.y + h31.y * d2_125.y + h31.z * d2_126.y + h31.w * d2_127.y + d2_128.y;
float y2 = h0.x * d2_0.z + h0.y * d2_1.z + h0.z * d2_2.z + h0.w * d2_3.z + h1.x * d2_4.z + h1.y * d2_5.z + h1.z * d2_6.z + h1.w * d2_7.z + h2.x * d2_8.z + h2.y * d2_9.z + h2.z * d2_10.z + h2.w * d2_11.z + h3.x * d2_12.z + h3.y * d2_13.z + h3.z * d2_14.z + h3.w * d2_15.z + h4.x * d2_16.z + h4.y * d2_17.z + h4.z * d2_18.z + h4.w * d2_19.z + h5.x * d2_20.z + h5.y * d2_21.z + h5.z * d2_22.z + h5.w * d2_23.z + h6.x * d2_24.z + h6.y * d2_25.z + h6.z * d2_26.z + h6.w * d2_27.z + h7.x * d2_28.z + h7.y * d2_29.z + h7.z * d2_30.z + h7.w * d2_31.z + h8.x * d2_32.z + h8.y * d2_33.z + h8.z * d2_34.z + h8.w * d2_35.z + h9.x * d2_36.z + h9.y * d2_37.z + h9.z * d2_38.z + h9.w * d2_39.z + h10.x * d2_40.z + h10.y * d2_41.z + h10.z * d2_42.z + h10.w * d2_43.z + h11.x * d2_44.z + h11.y * d2_45.z + h11.z * d2_46.z + h11.w * d2_47.z + h12.x * d2_48.z + h12.y * d2_49.z + h12.z * d2_50.z + h12.w * d2_51.z + h13.x * d2_52.z + h13.y * d2_53.z + h13.z * d2_54.z + h13.w * d2_55.z + h14.x * d2_56.z + h14.y * d2_57.z + h14.z * d2_58.z + h14.w * d2_59.z + h15.x * d2_60.z + h15.y * d2_61.z + h15.z * d2_62.z + h15.w * d2_63.z + h16.x * d2_64.z + h16.y * d2_65.z + h16.z * d2_66.z + h16.w * d2_67.z + h17.x * d2_68.z + h17.y * d2_69.z + h17.z * d2_70.z + h17.w * d2_71.z + h18.x * d2_72.z + h18.y * d2_73.z + h18.z * d2_74.z + h18.w * d2_75.z + h19.x * d2_76.z + h19.y * d2_77.z + h19.z * d2_78.z + h19.w * d2_79.z + h20.x * d2_80.z + h20.y * d2_81.z + h20.z * d2_82.z + h20.w * d2_83.z + h21.x * d2_84.z + h21.y * d2_85.z + h21.z * d2_86.z + h21.w * d2_87.z + h22.x * d2_88.z + h22.y * d2_89.z + h22.z * d2_90.z + h22.w * d2_91.z + h23.x * d2_92.z + h23.y * d2_93.z + h23.z * d2_94.z + h23.w * d2_95.z + h24.x * d2_96.z + h24.y * d2_97.z + h24.z * d2_98.z + h24.w * d2_99.z + h25.x * d2_100.z + h25.y * d2_101.z + h25.z * d2_102.z + h25.w * d2_103.z + h26.x * d2_104.z + h26.y * d2_105.z + h26.z * d2_106.z + h26.w * d2_107.z + h27.x * d2_108.z + h27.y * d2_109.z + h27.z * d2_110.z + h27.w * d2_111.z + h28.x * d2_112.z + h28.y * d2_113.z + h28.z * d2_114.z + h28.w * d2_115.z + h29.x * d2_116.z + h29.y * d2_117.z + h29.z * d2_118.z + h29.w * d2_119.z + h30.x * d2_120.z + h30.y * d2_121.z + h30.z * d2_122.z + h30.w * d2_123.z + h31.x * d2_124.z + h31.y * d2_125.z + h31.z * d2_126.z + h31.w * d2_127.z + d2_128.z;
float y3 = h0.x * d2_0.w + h0.y * d2_1.w + h0.z * d2_2.w + h0.w * d2_3.w + h1.x * d2_4.w + h1.y * d2_5.w + h1.z * d2_6.w + h1.w * d2_7.w + h2.x * d2_8.w + h2.y * d2_9.w + h2.z * d2_10.w + h2.w * d2_11.w + h3.x * d2_12.w + h3.y * d2_13.w + h3.z * d2_14.w + h3.w * d2_15.w + h4.x * d2_16.w + h4.y * d2_17.w + h4.z * d2_18.w + h4.w * d2_19.w + h5.x * d2_20.w + h5.y * d2_21.w + h5.z * d2_22.w + h5.w * d2_23.w + h6.x * d2_24.w + h6.y * d2_25.w + h6.z * d2_26.w + h6.w * d2_27.w + h7.x * d2_28.w + h7.y * d2_29.w + h7.z * d2_30.w + h7.w * d2_31.w + h8.x * d2_32.w + h8.y * d2_33.w + h8.z * d2_34.w + h8.w * d2_35.w + h9.x * d2_36.w + h9.y * d2_37.w + h9.z * d2_38.w + h9.w * d2_39.w + h10.x * d2_40.w + h10.y * d2_41.w + h10.z * d2_42.w + h10.w * d2_43.w + h11.x * d2_44.w + h11.y * d2_45.w + h11.z * d2_46.w + h11.w * d2_47.w + h12.x * d2_48.w + h12.y * d2_49.w + h12.z * d2_50.w + h12.w * d2_51.w + h13.x * d2_52.w + h13.y * d2_53.w + h13.z * d2_54.w + h13.w * d2_55.w + h14.x * d2_56.w + h14.y * d2_57.w + h14.z * d2_58.w + h14.w * d2_59.w + h15.x * d2_60.w + h15.y * d2_61.w + h15.z * d2_62.w + h15.w * d2_63.w + h16.x * d2_64.w + h16.y * d2_65.w + h16.z * d2_66.w + h16.w * d2_67.w + h17.x * d2_68.w + h17.y * d2_69.w + h17.z * d2_70.w + h17.w * d2_71.w + h18.x * d2_72.w + h18.y * d2_73.w + h18.z * d2_74.w + h18.w * d2_75.w + h19.x * d2_76.w + h19.y * d2_77.w + h19.z * d2_78.w + h19.w * d2_79.w + h20.x * d2_80.w + h20.y * d2_81.w + h20.z * d2_82.w + h20.w * d2_83.w + h21.x * d2_84.w + h21.y * d2_85.w + h21.z * d2_86.w + h21.w * d2_87.w + h22.x * d2_88.w + h22.y * d2_89.w + h22.z * d2_90.w + h22.w * d2_91.w + h23.x * d2_92.w + h23.y * d2_93.w + h23.z * d2_94.w + h23.w * d2_95.w + h24.x * d2_96.w + h24.y * d2_97.w + h24.z * d2_98.w + h24.w * d2_99.w + h25.x * d2_100.w + h25.y * d2_101.w + h25.z * d2_102.w + h25.w * d2_103.w + h26.x * d2_104.w + h26.y * d2_105.w + h26.z * d2_106.w + h26.w * d2_107.w + h27.x * d2_108.w + h27.y * d2_109.w + h27.z * d2_110.w + h27.w * d2_111.w + h28.x * d2_112.w + h28.y * d2_113.w + h28.z * d2_114.w + h28.w * d2_115.w + h29.x * d2_116.w + h29.y * d2_117.w + h29.z * d2_118.w + h29.w * d2_119.w + h30.x * d2_120.w + h30.y * d2_121.w + h30.z * d2_122.w + h30.w * d2_123.w + h31.x * d2_124.w + h31.y * d2_125.w + h31.z * d2_126.w + h31.w * d2_127.w + d2_128.w;

if (Texel(xin, mod(uv + d.xx, cs) / xss).a <= 0.1 && Texel(xin, mod(uv + d.xy, cs) / xss).a <= 0.1 && Texel(xin, mod(uv + d.xz, cs) / xss).a <= 0.1 && Texel(xin, mod(uv + d.yx, cs) / xss).a <= 0.1 && Texel(xin, mod(uv + d.yy, cs) / xss).a <= 0.1 && Texel(xin, mod(uv + d.yz, cs) / xss).a <= 0.1 && Texel(xin, mod(uv + d.zx, cs) / xss).a <= 0.1 && Texel(xin, mod(uv + d.zy, cs) / xss).a <= 0.1 && Texel(xin, mod(uv + d.zz, cs) / xss).a <= 0.1) { return vec4(0.0); }

    vec4 res = Texel(xin, screen_coords / xss);
    float update_mask = rand(mod(uv, cs) + randOffset) < 0.5 ? 1.0 : 0.0;
    res += vec4(y0, y1, y2, y3) * update_mask;

    return res;
}