# gt-v1

The Glamorous Toolkit is the moldable integrated development environment for Pharo. This reposiory contains the initial v1 version of Glamorous Toolkit present in Pharo 6 and Pharo 7. To load the latest v1 version you can use the following scripts. This loads the full Glamorous Toolkit including Roassal.

Pharo 7
```
Metacello new
   baseline: 'GToolkitV1';
   repository: 'github://moosetechnology/gt-v1/src';
   load.
```


Pharo 6
```
Metacello new
   baseline: 'GToolkitV1';
   repository: 'github://moosetechnology/gt-v1:pharo6/src';
   load.
```

If you depend on Glamorous Toolkit v1 in your configuration add a baseline dependency to github://moosetechnology/gt-v1:pharo6/src for Pharo 6 and to github://moosetechnology/gt-v1/src for Pharo 7.
