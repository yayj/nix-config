{
  disko,
  hostname,
  ...
}: {
  disko.devices.disk.vmdisk = {
    device = "/dev/sda";
    type = "disk";
    content = {
      type = "gpt";
      partitions = {
        ESP = {
          type = "EF00";
          size = "256M";
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
            mountOptions = ["umask=077"];
          };
        };
        root = {
          end = "-4G";
          content = {
            type = "filesystem";
            format = "ext4";
            mountpoint = "/";
          };
        };
        swap = {
          size = "100%";
          content = {
            type = "swap";
            discardPolicy = "both";
            resumeDevice = true;
          };
        };
      };
    };
  };

  networking = {
    hostName = hostname;
    defaultGateway = "172.27.254.1";
    nameservers = ["172.22.2.1" "1.1.1.1"];
    interfaces.eth0.ipv4.addresses = [
      {
        address = "172.27.254.7";
        prefixLength = 24;
      }
    ];
  };
}
