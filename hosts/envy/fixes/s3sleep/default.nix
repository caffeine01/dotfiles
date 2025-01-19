{ lib, config, ... }:
{
  # The HP Envy line of laptops has their BIOS quite locked down,
  # with no way to easily enable S3 sleep.
  # You have to settle for doing this bullshit lol.
  config = lib.mkMerge [ {
    boot = {
      initrd.prepend = [ "${./acpi_override.cpio}" ];
      kernelParams = [ 
        "mem_sleep_default=deep"
        "amdgpu.dc=1"
        "amdgpu.dpm=1"        
        "amdgpu.aspm=0"      
	"acpi.debug_level=0xFFFF"
	"acpi.debug_layer=0x2"
        ];
      };
  } ];
}
