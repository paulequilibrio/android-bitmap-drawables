# Android bitmap drawables

Creates alternative Android bitmap drawables for different densities.

You just need two base images on a directory:
- icon.png
- splash.png

The `icon.png` image shoud have 192x192px.

The `splash.png` should contain a 1200x1200px picture centralized on a 2208x2208px frame.

After run the `resources.sh` script you will have something like this:

```
├── icon.png
├── splash.png
└── android
    ├── icon
    │   ├── drawable-hdpi-icon.png
    │   ├── drawable-ldpi-icon.png
    │   ├── drawable-mdpi-icon.png
    │   ├── drawable-xhdpi-icon.png
    │   ├── drawable-xxhdpi-icon.png
    │   └── drawable-xxxhdpi-icon.png
    └── splash
        ├── drawable-land-hdpi-screen.png
        ├── drawable-land-ldpi-screen.png
        ├── drawable-land-mdpi-screen.png
        ├── drawable-land-xhdpi-screen.png
        ├── drawable-land-xxhdpi-screen.png
        ├── drawable-land-xxxhdpi-screen.png
        ├── drawable-port-hdpi-screen.png
        ├── drawable-port-ldpi-screen.png
        ├── drawable-port-mdpi-screen.png
        ├── drawable-port-xhdpi-screen.png
        ├── drawable-port-xxhdpi-screen.png
        └── drawable-port-xxxhdpi-screen.png
```
