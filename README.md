# Android bitmap drawables

Creates alternative Android bitmap drawables for different densities.

## Dependency
- [ImageMagick](https://imagemagick.org/)
  
## Usage

```shell
resources.sh [PATH_WITH_BASE_IMAGES]
```

You could use either absolute path or relative path.

If you don't provide the path, it will use the current directory.

## Using the example images

Download this repository and run:

```shell
./resources.sh example
```

## Using your own images

You just need two base images on a directory:

- `icon.png`
- `splash.png`

The `icon.png` should have `512x512`px.

The `splash.png` should contain a `1200x1200`px picture centralized on a `2208x2208`px frame.

Once you have these images, run the `resources.sh` script, and you'll get something like this:

```
├── icon.png
├── splash.png
└── res
    ├── drawable-land-hdpi
    │   └── screen.png
    ├── drawable-land-ldpi
    │   └── screen.png
    ├── drawable-land-mdpi
    │   └── screen.png
    ├── drawable-land-xhdpi
    │   └── screen.png
    ├── drawable-land-xxhdpi
    │   └── screen.png
    ├── drawable-land-xxxhdpi
    │   └── screen.png
    ├── drawable-port-hdpi
    │   └── screen.png
    ├── drawable-port-ldpi
    │   └── screen.png
    ├── drawable-port-mdpi
    │   └── screen.png
    ├── drawable-port-xhdpi
    │   └── screen.png
    ├── drawable-port-xxhdpi
    │   └── screen.png
    ├── drawable-port-xxxhdpi
    │   └── screen.png
    ├── mipmap-hdpi
    │   └── ic_launcher.png
    ├── mipmap-hdpi-v26
    │   ├── ic_launcher_background.png
    │   ├── ic_launcher_foreground.png
    │   └── ic_launcher.xml
    ├── mipmap-ldpi
    │   └── ic_launcher.png
    ├── mipmap-ldpi-v26
    │   ├── ic_launcher_background.png
    │   ├── ic_launcher_foreground.png
    │   └── ic_launcher.xml
    ├── mipmap-mdpi
    │   └── ic_launcher.png
    ├── mipmap-mdpi-v26
    │   ├── ic_launcher_background.png
    │   ├── ic_launcher_foreground.png
    │   └── ic_launcher.xml
    ├── mipmap-xhdpi
    │   └── ic_launcher.png
    ├── mipmap-xhdpi-v26
    │   ├── ic_launcher_background.png
    │   ├── ic_launcher_foreground.png
    │   └── ic_launcher.xml
    ├── mipmap-xxhdpi
    │   └── ic_launcher.png
    ├── mipmap-xxhdpi-v26
    │   ├── ic_launcher_background.png
    │   ├── ic_launcher_foreground.png
    │   └── ic_launcher.xml
    ├── mipmap-xxxhdpi
    │   └── ic_launcher.png
    └── mipmap-xxxhdpi-v26
        ├── ic_launcher_background.png
        ├── ic_launcher_foreground.png
        └── ic_launcher.xml

```

## Enjoy it!
