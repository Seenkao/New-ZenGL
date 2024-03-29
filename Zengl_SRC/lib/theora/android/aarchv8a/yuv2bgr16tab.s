	.text
	.file	"yuv2bgr16tab.c"
	.globl	get_yuv2bgr565_table    // -- Begin function get_yuv2bgr565_table
	.p2align	2
	.type	get_yuv2bgr565_table,@function
get_yuv2bgr565_table:                   // @get_yuv2bgr565_table
// %bb.0:
	adrp	x0, yuv2bgr565_table
	add	x0, x0, :lo12:yuv2bgr565_table
	ret
.Lfunc_end0:
	.size	get_yuv2bgr565_table, .Lfunc_end0-get_yuv2bgr565_table
                                        // -- End function
	.type	yuv2bgr565_table,@object // @yuv2bgr565_table
	.section	.rodata,"a",@progbits
	.globl	yuv2bgr565_table
	.p2align	2
yuv2bgr565_table:
	.word	2147446783              // 0x7fff6fff
	.word	2147450879              // 0x7fff7fff
	.word	2147452927              // 0x7fff87ff
	.word	2147454975              // 0x7fff8fff
	.word	2147457023              // 0x7fff97ff
	.word	2147459071              // 0x7fff9fff
	.word	2147461119              // 0x7fffa7ff
	.word	2147465215              // 0x7fffb7ff
	.word	2147467263              // 0x7fffbfff
	.word	2147469311              // 0x7fffc7ff
	.word	2147471359              // 0x7fffcfff
	.word	2147473407              // 0x7fffd7ff
	.word	2147475455              // 0x7fffdfff
	.word	2147479551              // 0x7fffefff
	.word	2147481599              // 0x7ffff7ff
	.word	2147483647              // 0x7fffffff
	.word	2147483648              // 0x80000000
	.word	2151680001              // 0x80400801
	.word	2157974530              // 0x80a01402
	.word	2162170883              // 0x80e01c03
	.word	2166369285              // 0x81202c05
	.word	2172661766              // 0x81803006
	.word	2176858119              // 0x81c03807
	.word	2181054472              // 0x82004008
	.word	2187349001              // 0x82604c09
	.word	2191545354              // 0x82a0540a
	.word	2195743756              // 0x82e0640c
	.word	2202036237              // 0x8340680d
	.word	2206232590              // 0x8380700e
	.word	2210428943              // 0x83c0780f
	.word	2216723472              // 0x84208410
	.word	2220919825              // 0x84608c11
	.word	2225118227              // 0x84a09c13
	.word	2231410708              // 0x8500a014
	.word	2235607061              // 0x8540a815
	.word	2239803414              // 0x8580b016
	.word	2246097943              // 0x85e0bc17
	.word	2250294296              // 0x8620c418
	.word	2254492698              // 0x8660d41a
	.word	2260785179              // 0x86c0d81b
	.word	2264981532              // 0x8700e01c
	.word	2269177885              // 0x8740e81d
	.word	2275472414              // 0x87a0f41e
	.word	2279668767              // 0x87e0fc1f
	.word	2283867169              // 0x88210c21
	.word	2290159650              // 0x88811022
	.word	2294356003              // 0x88c11823
	.word	2298552356              // 0x89012024
	.word	2302748709              // 0x89412825
	.word	2309043238              // 0x89a13426
	.word	2313241640              // 0x89e14428
	.word	2317437993              // 0x8a214c29
	.word	2323730474              // 0x8a81502a
	.word	2327926827              // 0x8ac1582b
	.word	2332123180              // 0x8b01602c
	.word	2338417709              // 0x8b616c2d
	.word	2342616111              // 0x8ba17c2f
	.word	2346812464              // 0x8be18430
	.word	2353104945              // 0x8c418831
	.word	2357301298              // 0x8c819032
	.word	2361497651              // 0x8cc19833
	.word	2367792180              // 0x8d21a434
	.word	2371990582              // 0x8d61b436
	.word	2376186935              // 0x8da1bc37
	.word	2382479416              // 0x8e01c038
	.word	2386675769              // 0x8e41c839
	.word	2390872122              // 0x8e81d03a
	.word	2397166651              // 0x8ee1dc3b
	.word	2401365053              // 0x8f21ec3d
	.word	2405561406              // 0x8f61f43e
	.word	2411853887              // 0x8fc1f83f
	.word	2416050240              // 0x90020040
	.word	2420246593              // 0x90420841
	.word	2426541122              // 0x90a21442
	.word	2430739524              // 0x90e22444
	.word	2434935877              // 0x91222c45
	.word	2441228358              // 0x91823046
	.word	2445424711              // 0x91c23847
	.word	2449621064              // 0x92024048
	.word	2455915593              // 0x92624c49
	.word	2460111946              // 0x92a2544a
	.word	2464310348              // 0x92e2644c
	.word	2470602829              // 0x9342684d
	.word	2474799182              // 0x9382704e
	.word	2478995535              // 0x93c2784f
	.word	2485290064              // 0x94228450
	.word	2489486417              // 0x94628c51
	.word	2493684819              // 0x94a29c53
	.word	2499977300              // 0x9502a054
	.word	2504173653              // 0x9542a855
	.word	2508370006              // 0x9582b056
	.word	2514664535              // 0x95e2bc57
	.word	2518860888              // 0x9622c458
	.word	2523059290              // 0x9662d45a
	.word	2529351771              // 0x96c2d85b
	.word	2533548124              // 0x9702e05c
	.word	2537744477              // 0x9742e85d
	.word	2544039006              // 0x97a2f45e
	.word	2548235359              // 0x97e2fc5f
	.word	2552433761              // 0x98230c61
	.word	2558726242              // 0x98831062
	.word	2562922595              // 0x98c31863
	.word	2567118948              // 0x99032064
	.word	2573413477              // 0x99632c65
	.word	2577609830              // 0x99a33466
	.word	2581808232              // 0x99e34468
	.word	2588100713              // 0x9a434869
	.word	2592297066              // 0x9a83506a
	.word	2596493419              // 0x9ac3586b
	.word	2602787948              // 0x9b23646c
	.word	2606984301              // 0x9b636c6d
	.word	2611182703              // 0x9ba37c6f
	.word	2615379056              // 0x9be38470
	.word	2621671537              // 0x9c438871
	.word	2625867890              // 0x9c839072
	.word	2630064243              // 0x9cc39873
	.word	2636358772              // 0x9d23a474
	.word	2640557174              // 0x9d63b476
	.word	2644753527              // 0x9da3bc77
	.word	2651046008              // 0x9e03c078
	.word	2655242361              // 0x9e43c879
	.word	2659438714              // 0x9e83d07a
	.word	2665733243              // 0x9ee3dc7b
	.word	2669931645              // 0x9f23ec7d
	.word	2674127998              // 0x9f63f47e
	.word	2680420479              // 0x9fc3f87f
	.word	2684616832              // 0xa0040080
	.word	2688813185              // 0xa0440881
	.word	2695107714              // 0xa0a41482
	.word	2699306116              // 0xa0e42484
	.word	2703502469              // 0xa1242c85
	.word	2709794950              // 0xa1843086
	.word	2713991303              // 0xa1c43887
	.word	2718187656              // 0xa2044088
	.word	2724482185              // 0xa2644c89
	.word	2728680587              // 0xa2a45c8b
	.word	2732876940              // 0xa2e4648c
	.word	2739169421              // 0xa344688d
	.word	2743365774              // 0xa384708e
	.word	2747562127              // 0xa3c4788f
	.word	2753856656              // 0xa4248490
	.word	2758055058              // 0xa4649492
	.word	2762251411              // 0xa4a49c93
	.word	2768543892              // 0xa504a094
	.word	2772740245              // 0xa544a895
	.word	2776936598              // 0xa584b096
	.word	2783231127              // 0xa5e4bc97
	.word	2787427480              // 0xa624c498
	.word	2791625882              // 0xa664d49a
	.word	2797918363              // 0xa6c4d89b
	.word	2802114716              // 0xa704e09c
	.word	2806311069              // 0xa744e89d
	.word	2812605598              // 0xa7a4f49e
	.word	2816801951              // 0xa7e4fc9f
	.word	2821000353              // 0xa8250ca1
	.word	2827292834              // 0xa88510a2
	.word	2831489187              // 0xa8c518a3
	.word	2835685540              // 0xa90520a4
	.word	2841980069              // 0xa9652ca5
	.word	2846176422              // 0xa9a534a6
	.word	2850374824              // 0xa9e544a8
	.word	2856667305              // 0xaa4548a9
	.word	2860863658              // 0xaa8550aa
	.word	2865060011              // 0xaac558ab
	.word	2871354540              // 0xab2564ac
	.word	2875550893              // 0xab656cad
	.word	2879749295              // 0xaba57caf
	.word	2886041776              // 0xac0580b0
	.word	2890238129              // 0xac4588b1
	.word	2894434482              // 0xac8590b2
	.word	2900729011              // 0xace59cb3
	.word	2904925364              // 0xad25a4b4
	.word	2909123766              // 0xad65b4b6
	.word	2913320119              // 0xada5bcb7
	.word	2919612600              // 0xae05c0b8
	.word	2923808953              // 0xae45c8b9
	.word	2928005306              // 0xae85d0ba
	.word	2934299835              // 0xaee5dcbb
	.word	2938498237              // 0xaf25ecbd
	.word	2942694590              // 0xaf65f4be
	.word	2948987071              // 0xafc5f8bf
	.word	2953183424              // 0xb00600c0
	.word	2957379777              // 0xb04608c1
	.word	2963674306              // 0xb0a614c2
	.word	2967872708              // 0xb0e624c4
	.word	2972069061              // 0xb1262cc5
	.word	2978361542              // 0xb18630c6
	.word	2982557895              // 0xb1c638c7
	.word	2986754248              // 0xb20640c8
	.word	2993048777              // 0xb2664cc9
	.word	2997247179              // 0xb2a65ccb
	.word	3001443532              // 0xb2e664cc
	.word	3007736013              // 0xb34668cd
	.word	3011932366              // 0xb38670ce
	.word	3016128719              // 0xb3c678cf
	.word	3022423248              // 0xb42684d0
	.word	3026621650              // 0xb46694d2
	.word	3030818003              // 0xb4a69cd3
	.word	3037110484              // 0xb506a0d4
	.word	3041306837              // 0xb546a8d5
	.word	3045503190              // 0xb586b0d6
	.word	3051797719              // 0xb5e6bcd7
	.word	3055996121              // 0xb626ccd9
	.word	3060192474              // 0xb666d4da
	.word	3066484955              // 0xb6c6d8db
	.word	3070681308              // 0xb706e0dc
	.word	3074877661              // 0xb746e8dd
	.word	3081172190              // 0xb7a6f4de
	.word	3085368543              // 0xb7e6fcdf
	.word	3089566945              // 0xb8270ce1
	.word	3095859426              // 0xb88710e2
	.word	3100055779              // 0xb8c718e3
	.word	3104252132              // 0xb90720e4
	.word	3110546661              // 0xb9672ce5
	.word	3114743014              // 0xb9a734e6
	.word	3118941416              // 0xb9e744e8
	.word	3125233897              // 0xba4748e9
	.word	3129430250              // 0xba8750ea
	.word	3133626603              // 0xbac758eb
	.word	3139921132              // 0xbb2764ec
	.word	3144117485              // 0xbb676ced
	.word	3148315887              // 0xbba77cef
	.word	3154608368              // 0xbc0780f0
	.word	3158804721              // 0xbc4788f1
	.word	3163001074              // 0xbc8790f2
	.word	3169295603              // 0xbce79cf3
	.word	3173491956              // 0xbd27a4f4
	.word	3177690358              // 0xbd67b4f6
	.word	3183982839              // 0xbdc7b8f7
	.word	3188179192              // 0xbe07c0f8
	.word	3192375545              // 0xbe47c8f9
	.word	3198670074              // 0xbea7d4fa
	.word	3202866427              // 0xbee7dcfb
	.word	3207064829              // 0xbf27ecfd
	.word	3213357310              // 0xbf87f0fe
	.word	3217553663              // 0xbfc7f8ff
	.word	3221750016              // 0xc0080100
	.word	3225946369              // 0xc0480901
	.word	3232240898              // 0xc0a81502
	.word	3236439300              // 0xc0e82504
	.word	3236439300              // 0xc0e82504
	.word	3236439300              // 0xc0e82504
	.word	3236439300              // 0xc0e82504
	.word	3236439300              // 0xc0e82504
	.word	3236439300              // 0xc0e82504
	.word	3236439300              // 0xc0e82504
	.word	3236439300              // 0xc0e82504
	.word	3236439300              // 0xc0e82504
	.word	3236439300              // 0xc0e82504
	.word	3236439300              // 0xc0e82504
	.word	3236439300              // 0xc0e82504
	.word	3236439300              // 0xc0e82504
	.word	3236439300              // 0xc0e82504
	.word	3236439300              // 0xc0e82504
	.word	3236439300              // 0xc0e82504
	.word	3236439300              // 0xc0e82504
	.word	206051328               // 0xc481800
	.word	203959296               // 0xc282c00
	.word	203963392               // 0xc283c00
	.word	201869312               // 0xc084800
	.word	199777280               // 0xbe85c00
	.word	197683200               // 0xbc86800
	.word	195591168               // 0xba87c00
	.word	195595264               // 0xba88c00
	.word	193501184               // 0xb889800
	.word	191409152               // 0xb68ac00
	.word	189315072               // 0xb48b800
	.word	189319168               // 0xb48c800
	.word	187227136               // 0xb28dc00
	.word	185133056               // 0xb08e800
	.word	183041024               // 0xae8fc00
	.word	183045120               // 0xae90c00
	.word	180951040               // 0xac91800
	.word	178859008               // 0xaa92c00
	.word	176764928               // 0xa893800
	.word	174672896               // 0xa694c00
	.word	174676992               // 0xa695c00
	.word	172582912               // 0xa496800
	.word	170490880               // 0xa297c00
	.word	168396800               // 0xa098800
	.word	168398848               // 0xa099000
	.word	166306816               // 0x9e9a400
	.word	164212736               // 0x9c9b000
	.word	162120704               // 0x9a9c400
	.word	162124800               // 0x9a9d400
	.word	160030720               // 0x989e000
	.word	157938688               // 0x969f400
	.word	155844608               // 0x94a0000
	.word	155848704               // 0x94a1000
	.word	153756672               // 0x92a2400
	.word	151662592               // 0x90a3000
	.word	149570560               // 0x8ea4400
	.word	147476480               // 0x8ca5000
	.word	147480576               // 0x8ca6000
	.word	145388544               // 0x8aa7400
	.word	143294464               // 0x88a8000
	.word	141202432               // 0x86a9400
	.word	141206528               // 0x86aa400
	.word	139112448               // 0x84ab000
	.word	137020416               // 0x82ac400
	.word	134926336               // 0x80ad000
	.word	134930432               // 0x80ae000
	.word	132838400               // 0x7eaf400
	.word	130744320               // 0x7cb0000
	.word	128652288               // 0x7ab1400
	.word	128656384               // 0x7ab2400
	.word	126562304               // 0x78b3000
	.word	124470272               // 0x76b4400
	.word	122376192               // 0x74b5000
	.word	120284160               // 0x72b6400
	.word	120288256               // 0x72b7400
	.word	118194176               // 0x70b8000
	.word	116102144               // 0x6eb9400
	.word	114008064               // 0x6cba000
	.word	114012160               // 0x6cbb000
	.word	111920128               // 0x6abc400
	.word	109826048               // 0x68bd000
	.word	107734016               // 0x66be400
	.word	107738112               // 0x66bf400
	.word	105644032               // 0x64c0000
	.word	103552000               // 0x62c1400
	.word	101457920               // 0x60c2000
	.word	99363840                // 0x5ec2c00
	.word	99367936                // 0x5ec3c00
	.word	97273856                // 0x5cc4800
	.word	95181824                // 0x5ac5c00
	.word	93087744                // 0x58c6800
	.word	93091840                // 0x58c7800
	.word	90999808                // 0x56c8c00
	.word	88905728                // 0x54c9800
	.word	86813696                // 0x52cac00
	.word	86817792                // 0x52cbc00
	.word	84723712                // 0x50cc800
	.word	82631680                // 0x4ecdc00
	.word	80537600                // 0x4cce800
	.word	80541696                // 0x4ccf800
	.word	78449664                // 0x4ad0c00
	.word	76355584                // 0x48d1800
	.word	74263552                // 0x46d2c00
	.word	72169472                // 0x44d3800
	.word	72173568                // 0x44d4800
	.word	70081536                // 0x42d5c00
	.word	67987456                // 0x40d6800
	.word	65895424                // 0x3ed7c00
	.word	65899520                // 0x3ed8c00
	.word	63805440                // 0x3cd9800
	.word	61713408                // 0x3adac00
	.word	59619328                // 0x38db800
	.word	59623424                // 0x38dc800
	.word	57531392                // 0x36ddc00
	.word	55437312                // 0x34de800
	.word	53345280                // 0x32dfc00
	.word	53349376                // 0x32e0c00
	.word	51255296                // 0x30e1800
	.word	49163264                // 0x2ee2c00
	.word	47069184                // 0x2ce3800
	.word	44977152                // 0x2ae4c00
	.word	44981248                // 0x2ae5c00
	.word	42887168                // 0x28e6800
	.word	40795136                // 0x26e7c00
	.word	38701056                // 0x24e8800
	.word	38705152                // 0x24e9800
	.word	36613120                // 0x22eac00
	.word	34519040                // 0x20eb800
	.word	32424960                // 0x1eec400
	.word	32429056                // 0x1eed400
	.word	30334976                // 0x1cee000
	.word	28242944                // 0x1aef400
	.word	26148864                // 0x18f0000
	.word	24056832                // 0x16f1400
	.word	24060928                // 0x16f2400
	.word	21966848                // 0x14f3000
	.word	19874816                // 0x12f4400
	.word	17780736                // 0x10f5000
	.word	17784832                // 0x10f6000
	.word	15692800                // 0xef7400
	.word	13598720                // 0xcf8000
	.word	11506688                // 0xaf9400
	.word	11510784                // 0xafa400
	.word	9416704                 // 0x8fb000
	.word	7324672                 // 0x6fc400
	.word	5230592                 // 0x4fd000
	.word	5234688                 // 0x4fe000
	.word	3142656                 // 0x2ff400
	.word	1048576                 // 0x100000
	.word	4293923840              // 0xfff01400
	.word	4291829760              // 0xffd02000
	.word	4291833856              // 0xffd03000
	.word	4289741824              // 0xffb04400
	.word	4287647744              // 0xff905000
	.word	4285555712              // 0xff706400
	.word	4285559808              // 0xff707400
	.word	4283465728              // 0xff508000
	.word	4281373696              // 0xff309400
	.word	4279279616              // 0xff10a000
	.word	4279283712              // 0xff10b000
	.word	4277191680              // 0xfef0c400
	.word	4275097600              // 0xfed0d000
	.word	4273005568              // 0xfeb0e400
	.word	4273009664              // 0xfeb0f400
	.word	4270915584              // 0xfe910000
	.word	4268823552              // 0xfe711400
	.word	4266729472              // 0xfe512000
	.word	4264637440              // 0xfe313400
	.word	4264641536              // 0xfe314400
	.word	4262545408              // 0xfe114800
	.word	4260453376              // 0xfdf15c00
	.word	4258359296              // 0xfdd16800
	.word	4258363392              // 0xfdd17800
	.word	4256271360              // 0xfdb18c00
	.word	4254177280              // 0xfd919800
	.word	4252085248              // 0xfd71ac00
	.word	4252089344              // 0xfd71bc00
	.word	4249995264              // 0xfd51c800
	.word	4247903232              // 0xfd31dc00
	.word	4245809152              // 0xfd11e800
	.word	4243717120              // 0xfcf1fc00
	.word	4243721216              // 0xfcf20c00
	.word	4241627136              // 0xfcd21800
	.word	4239535104              // 0xfcb22c00
	.word	4237441024              // 0xfc923800
	.word	4237445120              // 0xfc924800
	.word	4235353088              // 0xfc725c00
	.word	4233259008              // 0xfc526800
	.word	4231166976              // 0xfc327c00
	.word	4231171072              // 0xfc328c00
	.word	4229076992              // 0xfc129800
	.word	4226984960              // 0xfbf2ac00
	.word	4224890880              // 0xfbd2b800
	.word	4224894976              // 0xfbd2c800
	.word	4222802944              // 0xfbb2dc00
	.word	4220708864              // 0xfb92e800
	.word	4218616832              // 0xfb72fc00
	.word	4216522752              // 0xfb530800
	.word	4216526848              // 0xfb531800
	.word	4214434816              // 0xfb332c00
	.word	4212340736              // 0xfb133800
	.word	4210248704              // 0xfaf34c00
	.word	4210252800              // 0xfaf35c00
	.word	4208158720              // 0xfad36800
	.word	4206066688              // 0xfab37c00
	.word	4203972608              // 0xfa938800
	.word	4203976704              // 0xfa939800
	.word	4201884672              // 0xfa73ac00
	.word	4199790592              // 0xfa53b800
	.word	4197698560              // 0xfa33cc00
	.word	4197702656              // 0xfa33dc00
	.word	4195606528              // 0xfa13e000
	.word	4193514496              // 0xf9f3f400
	.word	4191420416              // 0xf9d40000
	.word	4189328384              // 0xf9b41400
	.word	4189332480              // 0xf9b42400
	.word	4187238400              // 0xf9943000
	.word	4185146368              // 0xf9744400
	.word	4183052288              // 0xf9545000
	.word	4183056384              // 0xf9546000
	.word	4180964352              // 0xf9347400
	.word	4178870272              // 0xf9148000
	.word	4176778240              // 0xf8f49400
	.word	4176782336              // 0xf8f4a400
	.word	4174688256              // 0xf8d4b000
	.word	4172596224              // 0xf8b4c400
	.word	4170502144              // 0xf894d000
	.word	4168410112              // 0xf874e400
	.word	4168414208              // 0xf874f400
	.word	4166320128              // 0xf8550000
	.word	4164228096              // 0xf8351400
	.word	4162134016              // 0xf8152000
	.word	4162138112              // 0xf8153000
	.word	4160046080              // 0xf7f54400
	.word	4157952000              // 0xf7d55000
	.word	4155859968              // 0xf7b56400
	.word	4155864064              // 0xf7b57400
	.word	4153769984              // 0xf7958000
	.word	4151677952              // 0xf7759400
	.word	4149583872              // 0xf755a000
	.word	4149587968              // 0xf755b000
	.word	4147495936              // 0xf735c400
	.word	4145401856              // 0xf715d000
	.word	4143309824              // 0xf6f5e400
	.word	4141215744              // 0xf6d5f000
	.word	4141219840              // 0xf6d60000
	.word	4139127808              // 0xf6b61400
	.word	4137033728              // 0xf6962000
	.word	4134941696              // 0xf6763400
	.word	4134945792              // 0xf6764400
	.word	4132851712              // 0xf6565000
	.word	4130759680              // 0xf6366400
	.word	4128665600              // 0xf6167000
	.word	4128667648              // 0xf6167800
	.word	4126575616              // 0xf5f68c00
	.word	4124481536              // 0xf5d69800
	.word	4122389504              // 0xf5b6ac00
	.word	4122393600              // 0xf5b6bc00
	.word	4120299520              // 0xf596c800
	.word	4118207488              // 0xf576dc00
	.word	4116113408              // 0xf556e800
	.word	4114021376              // 0xf536fc00
	.word	4114025472              // 0xf5370c00
	.word	4111931392              // 0xf5171800
	.word	4109839360              // 0xf4f72c00
	.word	4107745280              // 0xf4d73800
	.word	4107749376              // 0xf4d74800
	.word	4105657344              // 0xf4b75c00
	.word	4103563264              // 0xf4976800
	.word	4101471232              // 0xf4777c00
	.word	4101475328              // 0xf4778c00
	.word	4099381248              // 0xf4579800
	.word	4097289216              // 0xf437ac00
	.word	4095195136              // 0xf417b800
	.word	4093103104              // 0xf3f7cc00
	.word	4093107200              // 0xf3f7dc00
	.word	436207924               // 0x1a000134
	.word	434111797               // 0x19e00535
	.word	429917495               // 0x19a00537
	.word	425723193               // 0x19600539
	.word	423625018               // 0x1940013a
	.word	419430716               // 0x1900013c
	.word	415236413               // 0x18c0013d
	.word	413140287               // 0x18a0053f
	.word	408945984               // 0x18600540
	.word	404751682               // 0x18200542
	.word	402653508               // 0x18000144
	.word	398459205               // 0x17c00145
	.word	396363079               // 0x17a00547
	.word	392168776               // 0x17600548
	.word	387974474               // 0x1720054a
	.word	385876300               // 0x1700014c
	.word	381681997               // 0x16c0014d
	.word	377487695               // 0x1680014f
	.word	375391568               // 0x16600550
	.word	371197266               // 0x16200552
	.word	369099092               // 0x16000154
	.word	364904789               // 0x15c00155
	.word	360710487               // 0x15800157
	.word	358614360               // 0x15600558
	.word	354420058               // 0x1520055a
	.word	350225756               // 0x14e0055c
	.word	348127581               // 0x14c0015d
	.word	343933279               // 0x1480015f
	.word	341837152               // 0x14600560
	.word	337642850               // 0x14200562
	.word	333448548               // 0x13e00564
	.word	331350373               // 0x13c00165
	.word	327156071               // 0x13800167
	.word	322961768               // 0x13400168
	.word	320865642               // 0x1320056a
	.word	316671340               // 0x12e0056c
	.word	314573165               // 0x12c0016d
	.word	310378863               // 0x1280016f
	.word	306184560               // 0x12400170
	.word	304088434               // 0x12200572
	.word	299894132               // 0x11e00574
	.word	295699829               // 0x11a00575
	.word	293601655               // 0x11800177
	.word	289407352               // 0x11400178
	.word	287311226               // 0x1120057a
	.word	283116924               // 0x10e0057c
	.word	278922621               // 0x10a0057d
	.word	276824447               // 0x1080017f
	.word	272630144               // 0x10400180
	.word	268435842               // 0x10000182
	.word	266339716               // 0xfe00584
	.word	262145413               // 0xfa00585
	.word	260047239               // 0xf800187
	.word	255852936               // 0xf400188
	.word	251658634               // 0xf00018a
	.word	249562507               // 0xee0058b
	.word	245368205               // 0xea0058d
	.word	241173903               // 0xe60058f
	.word	239075728               // 0xe400190
	.word	234881426               // 0xe000192
	.word	232785299               // 0xde00593
	.word	228590997               // 0xda00595
	.word	224396695               // 0xd600597
	.word	222298520               // 0xd400198
	.word	218104218               // 0xd00019a
	.word	213909915               // 0xcc0019b
	.word	211813789               // 0xca0059d
	.word	207619487               // 0xc60059f
	.word	205521312               // 0xc4001a0
	.word	201327010               // 0xc0001a2
	.word	197132707               // 0xbc001a3
	.word	195036581               // 0xba005a5
	.word	190842279               // 0xb6005a7
	.word	186647976               // 0xb2005a8
	.word	184549802               // 0xb0001aa
	.word	180355499               // 0xac001ab
	.word	178259373               // 0xaa005ad
	.word	174065071               // 0xa6005af
	.word	169870768               // 0xa2005b0
	.word	167772594               // 0xa0001b2
	.word	163578291               // 0x9c001b3
	.word	159383989               // 0x98001b5
	.word	157287863               // 0x96005b7
	.word	153093560               // 0x92005b8
	.word	150995386               // 0x90001ba
	.word	146801083               // 0x8c001bb
	.word	142606781               // 0x88001bd
	.word	140510655               // 0x86005bf
	.word	136316352               // 0x82005c0
	.word	132122050               // 0x7e005c2
	.word	130023875               // 0x7c001c3
	.word	125829573               // 0x78001c5
	.word	123733447               // 0x76005c7
	.word	119539144               // 0x72005c8
	.word	115344842               // 0x6e005ca
	.word	113246667               // 0x6c001cb
	.word	109052365               // 0x68001cd
	.word	104858063               // 0x64001cf
	.word	102761936               // 0x62005d0
	.word	98567634                // 0x5e005d2
	.word	96469459                // 0x5c001d3
	.word	92275157                // 0x58001d5
	.word	88080855                // 0x54001d7
	.word	85984728                // 0x52005d8
	.word	81790426                // 0x4e005da
	.word	77596123                // 0x4a005db
	.word	75497949                // 0x48001dd
	.word	71303646                // 0x44001de
	.word	69207520                // 0x42005e0
	.word	65013218                // 0x3e005e2
	.word	60818915                // 0x3a005e3
	.word	58720741                // 0x38001e5
	.word	54526438                // 0x34001e6
	.word	50332136                // 0x30001e8
	.word	48236010                // 0x2e005ea
	.word	44041707                // 0x2a005eb
	.word	41943533                // 0x28001ed
	.word	37749230                // 0x24001ee
	.word	33554928                // 0x20001f0
	.word	31458802                // 0x1e005f2
	.word	27264499                // 0x1a005f3
	.word	23070197                // 0x16005f5
	.word	20972022                // 0x14001f6
	.word	16777720                // 0x10001f8
	.word	14681594                // 0xe005fa
	.word	10487291                // 0xa005fb
	.word	6292989                 // 0x6005fd
	.word	4194814                 // 0x4001fe
	.word	512                     // 0x200
	.word	4290773506              // 0xffc00202
	.word	4288677379              // 0xffa00603
	.word	4284483077              // 0xff600605
	.word	4280288774              // 0xff200606
	.word	4278190600              // 0xff000208
	.word	4273996298              // 0xfec0020a
	.word	4271900171              // 0xfea0060b
	.word	4267705869              // 0xfe60060d
	.word	4263511566              // 0xfe20060e
	.word	4261413392              // 0xfe000210
	.word	4257219090              // 0xfdc00212
	.word	4253024787              // 0xfd800213
	.word	4250928661              // 0xfd600615
	.word	4246734358              // 0xfd200616
	.word	4244636184              // 0xfd000218
	.word	4240441882              // 0xfcc0021a
	.word	4236247579              // 0xfc80021b
	.word	4234151453              // 0xfc60061d
	.word	4229957150              // 0xfc20061e
	.word	4225762848              // 0xfbe00620
	.word	4223664674              // 0xfbc00222
	.word	4219470371              // 0xfb800223
	.word	4217374245              // 0xfb600625
	.word	4213179942              // 0xfb200626
	.word	4208985640              // 0xfae00628
	.word	4206887465              // 0xfac00229
	.word	4202693163              // 0xfa80022b
	.word	4198498861              // 0xfa40022d
	.word	4196402734              // 0xfa20062e
	.word	4192208432              // 0xf9e00630
	.word	4190110257              // 0xf9c00231
	.word	4185915955              // 0xf9800233
	.word	4181721653              // 0xf9400235
	.word	4179625526              // 0xf9200636
	.word	4175431224              // 0xf8e00638
	.word	4171236921              // 0xf8a00639
	.word	4169138747              // 0xf880023b
	.word	4164944445              // 0xf840023d
	.word	4162848318              // 0xf820063e
	.word	4158654016              // 0xf7e00640
	.word	4154459713              // 0xf7a00641
	.word	4152361539              // 0xf7800243
	.word	4148167237              // 0xf7400245
	.word	4143972934              // 0xf7000246
	.word	4141876808              // 0xf6e00648
	.word	4137682505              // 0xf6a00649
	.word	4135584331              // 0xf680024b
	.word	4131390029              // 0xf640024d
	.word	4127195726              // 0xf600024e
	.word	4125099600              // 0xf5e00650
	.word	4120905297              // 0xf5a00651
	.word	4116710995              // 0xf5600653
	.word	4114612821              // 0xf5400255
	.word	4110418518              // 0xf5000256
	.word	4108322392              // 0xf4e00658
	.word	4104128089              // 0xf4a00659
	.word	4099933787              // 0xf460065b
	.word	4097835613              // 0xf440025d
	.word	4093641310              // 0xf400025e
	.word	4089447008              // 0xf3c00260
	.word	4087350881              // 0xf3a00661
	.word	4083156579              // 0xf3600663
	.word	4081058405              // 0xf3400265
	.word	4076864102              // 0xf3000266
	.word	4072669800              // 0xf2c00268
	.word	4070573673              // 0xf2a00669
	.word	4066379371              // 0xf260066b
	.word	4062185069              // 0xf220066d
	.word	4060086894              // 0xf200026e
	.word	4055892592              // 0xf1c00270
	.word	4053796465              // 0xf1a00671
	.word	4049602163              // 0xf1600673
	.word	4045407861              // 0xf1200675
	.word	4043309686              // 0xf1000276
	.word	4039115384              // 0xf0c00278
	.word	4034921081              // 0xf0800279
	.word	4032824955              // 0xf060067b
	.word	4028630652              // 0xf020067c
	.word	4026532478              // 0xf000027e
	.word	4022338176              // 0xefc00280
	.word	4018143873              // 0xef800281
	.word	4016047747              // 0xef600683
	.word	4011853444              // 0xef200684
	.word	4007659142              // 0xeee00686
	.word	4005560968              // 0xeec00288
	.word	4001366665              // 0xee800289
	.word	3999270539              // 0xee60068b
	.word	3995076236              // 0xee20068c
	.word	3990881934              // 0xede0068e
	.word	3988783760              // 0xedc00290
	.word	3984589457              // 0xed800291
	.word	3980395155              // 0xed400293
	.word	3978299028              // 0xed200694
	.word	3974104726              // 0xece00696
	.word	3972006552              // 0xecc00298
	.word	3967812249              // 0xec800299
	.word	3963617947              // 0xec40029b
	.word	3961521820              // 0xec20069c
	.word	3957327518              // 0xebe0069e
	.word	3953133216              // 0xeba006a0
	.word	3951035041              // 0xeb8002a1
	.word	3946840739              // 0xeb4002a3
	.word	3944744612              // 0xeb2006a4
	.word	3940550310              // 0xeae006a6
	.word	3936356008              // 0xeaa006a8
	.word	3934257833              // 0xea8002a9
	.word	3930063531              // 0xea4002ab
	.word	3925869228              // 0xea0002ac
	.word	3923773102              // 0xe9e006ae
	.word	3919578800              // 0xe9a006b0
	.word	3917480625              // 0xe98002b1
	.word	3913286323              // 0xe94002b3
	.word	3909092020              // 0xe90002b4
	.word	3906995894              // 0xe8e006b6
	.word	3902801592              // 0xe8a006b8
	.word	3898607289              // 0xe86006b9
	.word	3896509115              // 0xe84002bb
	.word	3892314812              // 0xe80002bc
	.word	3890218686              // 0xe7e006be
	.word	3886024384              // 0xe7a006c0
	.word	3881830081              // 0xe76006c1
	.word	3879731907              // 0xe74002c3
	.word	3875537604              // 0xe70002c4
	.word	3871343302              // 0xe6c002c6
	.word	3869247176              // 0xe6a006c8
	.word	3865052873              // 0xe66006c9
	.word	3860858571              // 0xe62006cb
	.size	yuv2bgr565_table, 3072


	.ident	"Android (5900059 based on r365631c) clang version 9.0.8 (https://android.googlesource.com/toolchain/llvm-project 207d7abc1a2abf3ef8d4301736d6a7ebc224a290) (based on LLVM 9.0.8svn)"
	.section	".note.GNU-stack","",@progbits
