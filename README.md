# Simple FPS Template (Godot)

A modular First-Person Shooter template built in Godot with clean, loosely coupled components—ideal for prototyping and extending gameplay systems.

## 🎮 Features

### Player Character
- **MovementComponent** – Handles player locomotion.
- **InputComponent** – Processes input independently for flexible control mapping.
- **InteractionComponent** – Enables object interaction via raycast or proximity.
- **HUD (UI)** – Displays minimal UI for interaction feedback and future extensibility.

### Environment
- **Test Interactable Objects** – Demonstrates how to create and connect interactable actors with the InteractionComponent.

### Enemy AI
- **Monster Character** – Chases the player when detected.
  - **MovementComponent** – Controls monster pathfinding and pursuit behavior.
  - **PerceptionComponent** – Performs simple line-of-sight checks and triggers chase sequences.
  - **AI Logic** – Basic decision-making for patrol and engage behavior using Godot navigation systems.

![image](https://github.com/user-attachments/assets/66b5491a-c9e8-4594-a8b1-2d99d751cb8a)
![image](https://github.com/user-attachments/assets/c8826662-c960-432a-95ca-d87735dc04ee)

## ⚙️ Design Philosophy

This template emphasizes:
- **Loose Coupling:** Components can be reused or replaced independently.
- **Clarity:** Modular structure aids debugging and scaling.
- **Extendability:** Plug-and-play new mechanics or UI without rewriting core systems.

## 🛠️ Getting Started
1. Open the project in [Godot 4.x].
2. Run the main scene to jump into the player controller test arena.
3. Interact with objects using the mapped input (e.g., `E` key).
4. Trigger the monster’s perception and test evasion mechanics.

## 📦 To Do (Future Ideas)

- Modular weapon system
- Health and damage system
- Level streaming or scene transitions
- Advanced AI states (searching, retreating, etc.)

---

Built with 🧠 + ☕ by Jojo
