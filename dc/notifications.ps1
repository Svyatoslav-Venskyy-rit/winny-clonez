# Svyatoslav Venskyy, ssv5593@rit.edu, 9/11/2026
# Additions needed for script to run
add-type -assemblyname presentationframework
add-type -assemblyname presentationcore
add-type -assemblyname windowsbase

# Notifications "Fancy" Details
$title = '   Communication from Captain Rex'
$message = '     For the REPUBLIC!!'
$imagepath = 'C:\Program Files\Galactic_Republic\logo.png'
$seconds = 10
$window = new-object system.windows.window
$window.title = $title
$window.width = 500
$window.height = 120
$window.windowstyle = 'none'
$window.resizemode = 'noresize'
$window.topmost = $true
$window.showintaskbar = $false
$window.background = 'gray'

# Creation of the workarea
$workarea = [system.windows.systemparameters]::workarea

# Window RUles/Limits
$window.left = $workarea.right - $window.width - 20
$window.top = $workarea.bottom - $window.height - 20

# Border Rules of the notification
$border = new-object system.windows.controls.border
$border.borderbrush = 'gray'
$border.borderthickness = 1
$border.cornerradius = 6
$border.padding = 15
$grid = new-object system.windows.controls.grid

# Width of the grid columns in the window
$column1 = new-object system.windows.controls.columndefinition
$column1.width = '90'
$column2 = new-object system.windows.controls.columndefinition
$column2.width = '*'

#implements the columns into the grid for front end
$grid.columndefinitions.add($column1)
$grid.columndefinitions.add($column2)

# if the image/png path exists then the notification happens
if (test-path $imagepath) {
    $image = new-object system.windows.controls.image
    $bitmap = new-object system.windows.media.imaging.bitmapimage
    $bitmap.begininit()
    $bitmap.urisource = new-object system.uri($imagepath)
    $bitmap.cacheoption = 'onload'
    $bitmap.endinit()
    $image.source = $bitmap
    $image.width = 100
    $image.height = 100
    $image.stretch = 'uniform'
    #object grid is set and assigning image to column0
    [system.windows.controls.grid]::setcolumn($image, 0)
    #image is added into grid
    $grid.children.add($image)
}

#details for the notification to look slightly better
$stack = new-object system.windows.controls.stackpanel
$stack.verticalalignment = 'center'
$titletext = new-object system.windows.controls.textblock
$titletext.text = $title
$titletext.fontsize = 18
$titletext.fontweight = 'bold'
$titletext.margin = '0,0,0,8'
$messagetext = new-object system.windows.controls.textblock
$messagetext.text = $message
$messagetext.fontsize = 14
$messagetext.textwrapping = 'wrap'
$stack.children.add($titletext)
$stack.children.add($messagetext)

# adding in the text messages into the grid for the notification 
[system.windows.controls.grid]::setcolumn($stack, 1)

$grid.children.add($stack)
$border.child = $grid
$window.content = $border
$timer = new-object system.windows.threading.dispatchertimer

#only open for the time limit which is 10 seconds
$timer.interval = [timespan]::fromseconds($seconds)
$timer.add_tick({
    $timer.stop()
    $window.close()
})

#timer starts and dialog box starts
$timer.start()
$window.showdialog() | out-null