{ lib, pkgs, isDarwin, ... }:
let
  confDir = if isDarwin then "Library/Rime" else "/nonexist";

  dpyVer = "69bf85d4dfe8bac139c36abbd68d530b8b6622ea";
  dpyFiles = lib.mapAttrs (name: sha256: {
    source = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/rime/rime-double-pinyin/${dpyVer}/${name}.schema.yaml";
      sha256 = sha256;
    };
    target = "${confDir}/${name}.schema.yaml";
  }) {
    double_pinyin = "1lv5wxn5ci6hy43v2vm21jpw4aq9p5h9vd36ay097mhcknlk0d3n";
    double_pinyin_flypy = "1ffl85y4xw78cgfp69gkd51i5gb0ficphim1hx14fhxpkiz2llkb";
  };

  dictVer = "2025.04.06";
  dicts = lib.mapAttrs (name: sha256: {
    source = pkgs.fetchurl {
      url = " https://github.com/iDvel/rime-ice/raw/refs/tags/${dictVer}/cn_dicts/${name}.dict.yaml";
      sha256 = sha256;
    };
    target = "${confDir}/dicts/${name}.dict.yaml";
  }) {
    "8105" = "0b0x7fn59r5d0zniagykw8syiqggcl2zcq6brahf3038mxsvdnm1";
    base = "0bjc4b5qjd52r0h1k07r4ishkv8w1fpkpw16mqlhx4svhzam9yq4";
    ext = "18zlf5zfvrpx9ms8n15xqnw1q1xvir1q0l3mf2fcbnvq72fxhfcr";
    others = "1y6jphdlgj5xv6xvh4gagcg0dq2gn83728h7ffwff5si4pr5cp6f";
    tencent = "05cq2b69gfpw28c3ybilr5qg8f2rsyv5z8sk2q4smc2dgnw9dj2h";
  };
in {
  home.file = lib.mkMerge [
    # Global configuration
    {
      "${confDir}/default.custom.yaml".source = ./rime/default.custom.yaml;
      "${confDir}/squirrel.custom.yaml".source = ./rime/squirrel.custom.yaml;
    }

    # Double pinyin
    {
      "${confDir}/double_pinyin_flypy.custom.yaml".source = ./rime/double_pinyin_flypy.custom.yaml;
    }
    dpyFiles

    # My dictionaries
    {
      "${confDir}/dicts/math.txt".source = ./rime/dicts/math.txt;
      "${confDir}/dicts/emoji.txt".source = ./rime/dicts/emoji.txt;
    }

    # Imported dictionaries
    {
      "${confDir}/imported.dict.yaml".source = ./rime/imported.dict.yaml;
    }
    dicts

    # Keyboard simulation of CSA layout
    {
      "${confDir}/csa.schema.yaml".source = ./rime/csa.schema.yaml;
      "${confDir}/csa.dict.yaml".source = ./rime/csa.dict.yaml;
      "${confDir}/lua/csa_processor.lua".source = ./rime/lua/csa_processor.lua;
    }
  ];
}
