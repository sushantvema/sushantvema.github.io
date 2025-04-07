---
title: Sketchup
date_created: 2025-04-05T19:25:51
date: 2025-04-05T19:25:55
tags:
  - resource
author: Sushant Vema
publish: true
---

## Timetracking

- 2025-04-05: 7pm -

---

## What is Sketchup?

Sketchup is a cross-platform proprietary 3d-modeling software released in 2000.
It was originally developed by Google and Last Software. It is now maintained by
Trimble Inc.

## Why am I learning SketchUp?

This summer I am embarking on a project to landscape the raw backyard of our new
house in Mountain House, CA. In order to visualize the end-product of a time-
and money-intensive project, and to satisfy and formalize the requirements of my
entire family, I will strive to learn as much as I need to about the software
in order to create a digital twin of the backyard.

Additionally, there are tangible constraints enforced by the neighborhood review
board for the design of the backyard. Another reason why the digital twin is so
important is because it will help contractors implement the design more
accurately and hold them accountable.

## Pricing

I am currently on a free trial of the MacOS license until April 14th, 2024.
After that, I can use my student status from UC Berkeley in order to purchase a
one-year license for $55 if it will add value for me.

## Templates

Within default templates to start a project from, there are:

- Simple
- Visualization
- Architectural
- Plan View
- Urban Planning
- Landscape
- Woodworking
- Interiors
- 3D Printing

> The template you choose when you first create a new model determines a lot of
> your model’s settings. SketchUp includes a few templates that represent the
> most common applications including architecture, construction, urban planning,
> and landscaping among others. You can select from one of these default
> templates from the Home section of the Welcome Window.
> ([link](https://help.sketchup.com/en/sketchup/setting-templates) )

In Preferences, there are more templates to choose from.

You can see the settings associated with your model in the Model Info window.
The following categories of model settings are:

- Animation
- Classifications
  - [building information
    modeling](https://en.wikipedia.org/wiki/Building_information_modeling), etc
- Components
- Credits
- Dimensions
- File
- Geo-location
- Rendering
- Statistics
- Text
- Units

I'll start off with the landscape template.

## Creating a 3D Model

### [Drawing Lines, Shapes, and 3D Objects](https://help.sketchup.com/en/sketchup/drawing-lines-shapes-and-3d-objects)

> _...create edges and faces, (the basic entities of any SketchUp model and also
> discover how the SketchUp inference engine can help_

Drawing a Line:

- Line Tool (`L`) to draw edges (aka line entities)
  - Dynamic line creation is intuitive
  - Create line of specific length using by typing in a number and then `return`
  - Edit line length - select Move tool (`M`), hover over one of the end points,
    click and drag to change length, or edit in the Length box

Creating a Face:

- Several lines joined into a shape creates a face.
- By default SketchUp adds shading to some faces.
- Slightly automated by shape tools (below)

Dividing faces:

- When you draw a line or curve on an existing face, you 'split' the face.
  - After splitting a face, you can push or pull it.

Opening 3D shapes by erasing edges and faces:

- Using the Erase Tool (`E`), you can modify the 3d shape by erasing an edge or
  a face. Erasing an edge removes any adjacent faces.
- Can bring back ('heal') deleted faces using the logical `CMD + Z` or regular
  undo operation

Knowing your Inference Types:

- "SketchUp often combines inferences together to form a complex inference.
  Components and dynamic components have their own inference types"
- TODO: Reflect on all of the different inference types

### [Viewing a Model](https://help.sketchup.com/en/sketchup/viewing-model)

- **Orbit:** Around, above, below model
  - `CMD + B` or `O`
  - Yaw by holding `option` while in orbit tool
- **Zoom:**
  - Zoom Extents (`Shift + Z`)
  - Zoom Window
  - Changing field of view or focal length
- **Pan**
  - `CMD + R` or `H`
- **Camera Menu**: default, top, bottom, left, right, front, back, iso views
  - Hotkeys: `CMD + Number`. In my case (custom MacOS configuration), I've
    overwritten these hotkeys to auto-switch to corresponding 'Desktop Spaces'.
    So, I'll do these camera POV swaps manually.
- **Perspectives:** Parallel projection (orthographic view), perspective
  (default, vanishing horizon lines), 2 point perspective
