# No Hinting Please

Thanks to [otfcc](https://github.com/caryll/otfcc) and UniteTTC

## Usage
*Requires Powershell Core 7.0+ to use parallelization*

Put fonts in `./input/`, and run the `nhp.ps1`, it will generate fonts without hinting in `./output/`.

## Troubleshooting
 - Out of Memory: edit the `nhp.ps1` and decrease the `ThrottleLimit` args *(default 5)*
