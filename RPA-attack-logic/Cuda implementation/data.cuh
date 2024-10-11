 typedef unsigned char byte;
 
 __device__ byte inv_sbox[] = { 0x52, 0x09, 0x6a, 0xd5, 0x30, 0x36, 0xa5, 0x38, 0xbf, 0x40, 0xa3, 0x9e, 0x81, 0xf3, 0xd7, 0xfb, 
      0x7c, 0xe3, 0x39, 0x82, 0x9b, 0x2f, 0xff, 0x87, 0x34, 0x8e, 0x43, 0x44, 0xc4, 0xde, 0xe9, 0xcb, 
      0x54, 0x7b, 0x94, 0x32, 0xa6, 0xc2, 0x23, 0x3d, 0xee, 0x4c, 0x95, 0x0b, 0x42, 0xfa, 0xc3, 0x4e, 
      0x08, 0x2e, 0xa1, 0x66, 0x28, 0xd9, 0x24, 0xb2, 0x76, 0x5b, 0xa2, 0x49, 0x6d, 0x8b, 0xd1, 0x25, 
      0x72, 0xf8, 0xf6, 0x64, 0x86, 0x68, 0x98, 0x16, 0xd4, 0xa4, 0x5c, 0xcc, 0x5d, 0x65, 0xb6, 0x92, 
      0x6c, 0x70, 0x48, 0x50, 0xfd, 0xed, 0xb9, 0xda, 0x5e, 0x15, 0x46, 0x57, 0xa7, 0x8d, 0x9d, 0x84, 
      0x90, 0xd8, 0xab, 0x00, 0x8c, 0xbc, 0xd3, 0x0a, 0xf7, 0xe4, 0x58, 0x05, 0xb8, 0xb3, 0x45, 0x06, 
      0xd0, 0x2c, 0x1e, 0x8f, 0xca, 0x3f, 0x0f, 0x02, 0xc1, 0xaf, 0xbd, 0x03, 0x01, 0x13, 0x8a, 0x6b, 
      0x3a, 0x91, 0x11, 0x41, 0x4f, 0x67, 0xdc, 0xea, 0x97, 0xf2, 0xcf, 0xce, 0xf0, 0xb4, 0xe6, 0x73, 
      0x96, 0xac, 0x74, 0x22, 0xe7, 0xad, 0x35, 0x85, 0xe2, 0xf9, 0x37, 0xe8, 0x1c, 0x75, 0xdf, 0x6e, 
      0x47, 0xf1, 0x1a, 0x71, 0x1d, 0x29, 0xc5, 0x89, 0x6f, 0xb7, 0x62, 0x0e, 0xaa, 0x18, 0xbe, 0x1b, 
      0xfc, 0x56, 0x3e, 0x4b, 0xc6, 0xd2, 0x79, 0x20, 0x9a, 0xdb, 0xc0, 0xfe, 0x78, 0xcd, 0x5a, 0xf4, 
      0x1f, 0xdd, 0xa8, 0x33, 0x88, 0x07, 0xc7, 0x31, 0xb1, 0x12, 0x10, 0x59, 0x27, 0x80, 0xec, 0x5f, 
      0x60, 0x51, 0x7f, 0xa9, 0x19, 0xb5, 0x4a, 0x0d, 0x2d, 0xe5, 0x7a, 0x9f, 0x93, 0xc9, 0x9c, 0xef, 
      0xa0, 0xe0, 0x3b, 0x4d, 0xae, 0x2a, 0xf5, 0xb0, 0xc8, 0xeb, 0xbb, 0x3c, 0x83, 0x53, 0x99, 0x61, 
      0x17, 0x2b, 0x04, 0x7e, 0xba, 0x77, 0xd6, 0x26, 0xe1, 0x69, 0x14, 0x63, 0x55, 0x21, 0x0c, 0x7d };

__device__ unsigned int inv_shift[] = { 0, 5, 10, 15, 4, 9, 14, 3, 8, 13, 2, 7, 12, 1, 6, 11 };

__device__ byte rkey[]={0x4a, 0xd8, 0x52, 0x96, 0xe2, 0x40, 0x2a, 0x5b, 0xea, 0xb7, 0xee, 0xb2, 0x66, 0xb9, 0x42, 0xce};
// 40      2a      5b      f1      b7      ee      b2      66      b9      42      ce
//4a      d8      52      96      e2      40      2a      5b      ea      b7      ee      b2      66      b9      42      ce



__device__ byte sbox[] = {0x63, 0x7C, 0x77, 0x7B, 0xF2, 0x6B, 0x6F, 0xC5, 0x30, 0x01, 0x67, 0x2B, 0xFE, 0xD7, 0xAB, 0x76,
   0xCA, 0x82, 0xC9, 0x7D, 0xFA, 0x59, 0x47, 0xF0, 0xAD, 0xD4, 0xA2, 0xAF, 0x9C, 0xA4, 0x72, 0xC0,
   0xB7, 0xFD, 0x93, 0x26, 0x36, 0x3F, 0xF7, 0xCC, 0x34, 0xA5, 0xE5, 0xF1, 0x71, 0xD8, 0x31, 0x15,
   0x04, 0xC7, 0x23, 0xC3, 0x18, 0x96, 0x05, 0x9A, 0x07, 0x12, 0x80, 0xE2, 0xEB, 0x27, 0xB2, 0x75,
   0x09, 0x83, 0x2C, 0x1A, 0x1B, 0x6E, 0x5A, 0xA0, 0x52, 0x3B, 0xD6, 0xB3, 0x29, 0xE3, 0x2F, 0x84,
   0x53, 0xD1, 0x00, 0xED, 0x20, 0xFC, 0xB1, 0x5B, 0x6A, 0xCB, 0xBE, 0x39, 0x4A, 0x4C, 0x58, 0xCF,
   0xD0, 0xEF, 0xAA, 0xFB, 0x43, 0x4D, 0x33, 0x85, 0x45, 0xF9, 0x02, 0x7F, 0x50, 0x3C, 0x9F, 0xA8,
   0x51, 0xA3, 0x40, 0x8F, 0x92, 0x9D, 0x38, 0xF5, 0xBC, 0xB6, 0xDA, 0x21, 0x10, 0xFF, 0xF3, 0xD2,
   0xCD, 0x0C, 0x13, 0xEC, 0x5F, 0x97, 0x44, 0x17, 0xC4, 0xA7, 0x7E, 0x3D, 0x64, 0x5D, 0x19, 0x73,
   0x60, 0x81, 0x4F, 0xDC, 0x22, 0x2A, 0x90, 0x88, 0x46, 0xEE, 0xB8, 0x14, 0xDE, 0x5E, 0x0B, 0xDB,
   0xE0, 0x32, 0x3A, 0x0A, 0x49, 0x06, 0x24, 0x5C, 0xC2, 0xD3, 0xAC, 0x62, 0x91, 0x95, 0xE4, 0x79,
   0xE7, 0xC8, 0x37, 0x6D, 0x8D, 0xD5, 0x4E, 0xA9, 0x6C, 0x56, 0xF4, 0xEA, 0x65, 0x7A, 0xAE, 0x08,
   0xBA, 0x78, 0x25, 0x2E, 0x1C, 0xA6, 0xB4, 0xC6, 0xE8, 0xDD, 0x74, 0x1F, 0x4B, 0xBD, 0x8B, 0x8A,
   0x70, 0x3E, 0xB5, 0x66, 0x48, 0x03, 0xF6, 0x0E, 0x61, 0x35, 0x57, 0xB9, 0x86, 0xC1, 0x1D, 0x9E,
   0xE1, 0xF8, 0x98, 0x11, 0x69, 0xD9, 0x8E, 0x94, 0x9B, 0x1E, 0x87, 0xE9, 0xCE, 0x55, 0x28, 0xDF,
   0x8C, 0xA1, 0x89, 0x0D, 0xBF, 0xE6, 0x42, 0x68, 0x41, 0x99, 0x2D, 0x0F, 0xB0, 0x54, 0xBB, 0x16};


__device__ unsigned int  tbox[] =
{
            0xC66363A5, 0xF87C7C84, 0xEE777799, 0xF67B7B8D, 
    0xFFF2F20D, 0xD66B6BBD, 0xDE6F6FB1, 0x91C5C554, 
    0x60303050, 0x02010103, 0xCE6767A9, 0x562B2B7D, 
    0xE7FEFE19, 0xB5D7D762, 0x4DABABE6, 0xEC76769A, 
    0x8FCACA45, 0x1F82829D, 0x89C9C940, 0xFA7D7D87, 
    0xEFFAFA15, 0xB25959EB, 0x8E4747C9, 0xFBF0F00B, 
    0x41ADADEC, 0xB3D4D467, 0x5FA2A2FD, 0x45AFAFEA, 
    0x239C9CBF, 0x53A4A4F7, 0xE4727296, 0x9BC0C05B, 
    0x75B7B7C2, 0xE1FDFD1C, 0x3D9393AE, 0x4C26266A, 
    0x6C36365A, 0x7E3F3F41, 0xF5F7F702, 0x83CCCC4F, 
    0x6834345C, 0x51A5A5F4, 0xD1E5E534, 0xF9F1F108, 
    0xE2717193, 0xABD8D873, 0x62313153, 0x2A15153F, 
    0x0804040C, 0x95C7C752, 0x46232365, 0x9DC3C35E, 
    0x30181828, 0x379696A1, 0x0A05050F, 0x2F9A9AB5, 
    0x0E070709, 0x24121236, 0x1B80809B, 0xDFE2E23D, 
    0xCDEBEB26, 0x4E272769, 0x7FB2B2CD, 0xEA75759F, 
    0x1209091B, 0x1D83839E, 0x582C2C74, 0x341A1A2E, 
    0x361B1B2D, 0xDC6E6EB2, 0xB45A5AEE, 0x5BA0A0FB, 
    0xA45252F6, 0x763B3B4D, 0xB7D6D661, 0x7DB3B3CE, 
    0x5229297B, 0xDDE3E33E, 0x5E2F2F71, 0x13848497, 
    0xA65353F5, 0xB9D1D168, 0x00000000, 0xC1EDED2C, 
    0x40202060, 0xE3FCFC1F, 0x79B1B1C8, 0xB65B5BED, 
    0xD46A6ABE, 0x8DCBCB46, 0x67BEBED9, 0x7239394B, 
    0x944A4ADE, 0x984C4CD4, 0xB05858E8, 0x85CFCF4A, 
    0xBBD0D06B, 0xC5EFEF2A, 0x4FAAAAE5, 0xEDFBFB16, 
    0x864343C5, 0x9A4D4DD7, 0x66333355, 0x11858594, 
    0x8A4545CF, 0xE9F9F910, 0x04020206, 0xFE7F7F81, 
    0xA05050F0, 0x783C3C44, 0x259F9FBA, 0x4BA8A8E3, 
    0xA25151F3, 0x5DA3A3FE, 0x804040C0, 0x058F8F8A, 
    0x3F9292AD, 0x219D9DBC, 0x70383848, 0xF1F5F504, 
    0x63BCBCDF, 0x77B6B6C1, 0xAFDADA75, 0x42212163, 
    0x20101030, 0xE5FFFF1A, 0xFDF3F30E, 0xBFD2D26D, 
    0x81CDCD4C, 0x180C0C14, 0x26131335, 0xC3ECEC2F, 
    0xBE5F5FE1, 0x359797A2, 0x884444CC, 0x2E171739, 
    0x93C4C457, 0x55A7A7F2, 0xFC7E7E82, 0x7A3D3D47, 
    0xC86464AC, 0xBA5D5DE7, 0x3219192B, 0xE6737395, 
    0xC06060A0, 0x19818198, 0x9E4F4FD1, 0xA3DCDC7F, 
    0x44222266, 0x542A2A7E, 0x3B9090AB, 0x0B888883, 
    0x8C4646CA, 0xC7EEEE29, 0x6BB8B8D3, 0x2814143C, 
    0xA7DEDE79, 0xBC5E5EE2, 0x160B0B1D, 0xADDBDB76, 
    0xDBE0E03B, 0x64323256, 0x743A3A4E, 0x140A0A1E, 
    0x924949DB, 0x0C06060A, 0x4824246C, 0xB85C5CE4, 
    0x9FC2C25D, 0xBDD3D36E, 0x43ACACEF, 0xC46262A6, 
    0x399191A8, 0x319595A4, 0xD3E4E437, 0xF279798B, 
    0xD5E7E732, 0x8BC8C843, 0x6E373759, 0xDA6D6DB7, 
    0x018D8D8C, 0xB1D5D564, 0x9C4E4ED2, 0x49A9A9E0, 
    0xD86C6CB4, 0xAC5656FA, 0xF3F4F407, 0xCFEAEA25, 
    0xCA6565AF, 0xF47A7A8E, 0x47AEAEE9, 0x10080818, 
    0x6FBABAD5, 0xF0787888, 0x4A25256F, 0x5C2E2E72, 
    0x381C1C24, 0x57A6A6F1, 0x73B4B4C7, 0x97C6C651, 
    0xCBE8E823, 0xA1DDDD7C, 0xE874749C, 0x3E1F1F21, 
    0x964B4BDD, 0x61BDBDDC, 0x0D8B8B86, 0x0F8A8A85, 
    0xE0707090, 0x7C3E3E42, 0x71B5B5C4, 0xCC6666AA, 
    0x904848D8, 0x06030305, 0xF7F6F601, 0x1C0E0E12, 
    0xC26161A3, 0x6A35355F, 0xAE5757F9, 0x69B9B9D0, 
    0x17868691, 0x99C1C158, 0x3A1D1D27, 0x279E9EB9, 
    0xD9E1E138, 0xEBF8F813, 0x2B9898B3, 0x22111133, 
    0xD26969BB, 0xA9D9D970, 0x078E8E89, 0x339494A7, 
    0x2D9B9BB6, 0x3C1E1E22, 0x15878792, 0xC9E9E920, 
    0x87CECE49, 0xAA5555FF, 0x50282878, 0xA5DFDF7A, 
    0x038C8C8F, 0x59A1A1F8, 0x09898980, 0x1A0D0D17, 
    0x65BFBFDA, 0xD7E6E631, 0x844242C6, 0xD06868B8, 
    0x824141C3, 0x299999B0, 0x5A2D2D77, 0x1E0F0F11, 
    0x7BB0B0CB, 0xA85454FC, 0x6DBBBBD6, 0x2C16163A,
    };
