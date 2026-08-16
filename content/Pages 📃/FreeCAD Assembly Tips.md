---
aliases:
  - Assembly Tips
---
Over the years I've been using FreeCAD for my personal projects, I've learned a few things about assemblies from other FreeCAD users and from the pain of experience. I'd like to share them with you here. Here I'm discussing the Assembly Workbench built-in to FreeCAD version 1.0 and up. I don't have any experience with the older or alternative workbenches.

# Do you really need an assembly?

This is the first question you should ask yourself before starting. I would say that if the object your modeling is made of five or fewer static components, you're better off simply manually moving them using the Placement property of each body. You can even use this collection of bodies in a larger assembly by wrapping them all within a [part container](https://wiki.freecad.org/Part).

Since there's only a few parts, and they don't move, there's really no need to bring in the added overhead of an Assembly container. The benefits of the assembly workbench really come in when your model is designed to change in size, or when parts move, or when there are just so many parts you would benefit from organizing your project into smaller sub-assemblies.


-----
Reference #sources/gemini

Manually positioning bodies using their **Placement** property works perfectly fine for simple projects, but it quickly hits a wall when a design gets complex or needs to change.

Using the **Assembly workbench** (the built-in Assembly3, Assembly4, or the official **Assembly** workbench integrated in FreeCAD 1.0+) shifts the paradigm from _static coordinate tracking_ to _relational design_.

Here is a breakdown of why and when you should make the switch.

## 1. Relational Constraints vs. Hardcoded Coordinates

When you use the manual **Placement** property, you are positioning bodies in absolute space relative to the global origin. If you have a bookshelf side panel at $X = 0$ and a shelf at $X = 18$ inches, those numbers are completely disconnected.

- **The Manual Flaw:** If you decide later to make the bookshelf 24 inches wide instead of 18, you have to manually calculate and change the Placement coordinate of the right side panel, plus reposition every single shelf, screw, and support pin individually.
    
- **The Assembly Advantage:** In the Assembly workbench, you define **Joints or Constraints** (like _Coincident_, _Parallel_, or _Distance_). You tell FreeCAD: _"This shelf surface is flush with the inside groove of this side panel."_ If you change the width of the shelf, the side panel automatically moves with it to maintain that structural relationship.
    

## 2. Proper Bill of Materials (BOM) & Instancing

If your bookshelf uses six identical shelves, the manual approach usually requires you to either duplicate the body (creating heavy, independent copies) or clone it.

- **The Assembly Advantage:** The Assembly workbench uses true **Instancing**. You design _one_ shelf body, and then drag it into the assembly six times.
    
- FreeCAD tracks these as multiple instances of the same original part. If you add a chamfer or change the thickness of the base shelf model, **all six shelves update simultaneously**.
    
- Furthermore, this allows FreeCAD to generate a clean, automated Bill of Materials (e.g., _"Quantity: 6 of Part_Shelf"_), which is crucial for woodworking cut lists or hardware counts.
    

## 3. Kinematics and Motion Simulation

While a bookshelf is static, if you ever model a project with moving parts—like a cabinet door with hinges, a drawer runner, or a folding workbench mechanism—manual placement is practically useless for testing.

- **The Assembly Advantage:** Assembly joints define degrees of freedom. You can set a **Revolute Joint** for a hinge or a **Slider Joint** for a drawer. This lets you physically click and drag the component in the 3D viewer to check for clearance, ensuring your cabinet doors don't bind against the frame when they swing open.
    

## Direct Comparison: When to Use Which

|**Feature / Scenario**|**Manual Placement (Bodies in a Part)**|**Assembly Workbench**|
|---|---|---|
|**Project Complexity**|Very Low (under 3–5 unique parts)|Medium to High (multiple joints, hardware)|
|**Design Intent**|Static, fixed geometry|Parametric, subject to dimension changes|
|**File Management**|Best for single-file, self-contained models|Great for multi-file workflows (linking external parts)|
|**Performance**|Can get laggy if bodies are duplicated|Highly efficient due to part instancing|
|**Motion/Clearance**|Blind guesswork|Interactive kinematic testing|

## The Verdict: Which should you use for a bookshelf?

For a **basic, static bookshelf**, you can honestly go either way. If you use a master sketch with global aliases (Spreadsheet workbench) to drive your manual Placements, it can function quite dynamically.

However, **you should use the Assembly workbench if:**

1. You plan to reuse standard hardware (like shelf pins, pocket screws, or hinges) across multiple locations.
    
2. You want to practice a professional, industry-standard CAD workflow where parts are modeled cleanly in their own space and "bolted together" logically.
    
3. You foresee yourself changing global dimensions (Height, Width, Depth) and want the entire furniture piece to resize itself flawlessly without manual math.