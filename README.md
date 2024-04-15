# Image Splitter
Image Splitter is a Godot script that provides functionality to vertically split an image, move the split images to the left and right, and then remove them.

<img width="688" alt="image" src="https://github.com/zondug/ImageSplitter/assets/13306437/91ac8e61-a359-4caa-8c90-018fa9dc93e8">

## Features

- Displays the original image.
- Draws a vertical line at the center of the image after 0.5 seconds.
- Splits the image into left and right parts and moves them apart after 0.5 seconds.
- Removes all images after 1 second.

## Usage

1. Add the `image_splitter.gd` file to your project.
2. Create a new Node2D node in your 2D scene.
3. Attach the `image_splitter.gd` script to the Node2D node.
4. Adjust the script properties as needed:
   - `split_delay`: The time it takes for the split images to move apart after splitting (default: 0.5 seconds)
   - `move_distance`: The distance the split images move to the left and right (default: 20 pixels)
   - `remove_delay`: The delay before the split images are removed (default: 1 second)
5. When the scene runs, the image splitting, moving, and removal actions will be performed automatically.

## Requirements

- Godot Engine 3.x or higher

## Script Structure

- `_ready()`: Called when the node is initialized. Loads and displays the original image. Then, it performs the actions of drawing the vertical line, splitting and moving the images, and removing the images at specified time intervals.
- `draw_vertical_line()`: Draws a vertical line at the center of the original image.
- `split_image()`: Splits the original image into left and right parts and moves the split images apart.
- `remove_sprites()`: Removes the original image and the split images.

## License

This project is distributed under the MIT License. See the `LICENSE` file for more information.
