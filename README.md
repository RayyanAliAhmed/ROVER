# PDDL Lunar Exploration Planner

## 📁 Project Overview

This repository contains PDDL (Planning Domain Definition Language) domain and problem files for modeling lunar exploration missions. The project includes two progressively complex domain models and three corresponding problem instances that test planning capabilities for single-agent and multi-agent coordination scenarios.

## 🧠 Domain Files

### 1. **lunar.pddl** (Base Domain)
- **Type:** STRIPS with typing
- **Agents:** Rover only
- **Key Features:**
  - Basic lunar exploration with waypoint navigation
  - Single-slot memory buffer for data (image/scan)
  - Sample collection and data transmission mechanics
  - Deterministic action model

### 2. **lunar-extended.pddl** (Extended Domain)
- **Type:** STRIPS with typing
- **Agents:** Rover + Astronaut
- **Key Additions:**
  - Introduces human astronauts as separate agents
  - Adds internal base areas (control room, docking bay)
  - Requires astronaut presence for data transmission
  - Multi-agent coordination constraints

## 🎯 Problem Files

| File | Agents | Domain Used | Key Challenge |
|------|--------|-------------|---------------|
| `Mission1.pddl` | 1 Rover | Base | Sequential task completion with memory constraint |
| `Mission2.pddl` | 2 Rovers | Base | Parallel execution with two independent rovers |
| `Mission3.pddl` | 2 Rovers + 2 Astronauts | Extended | Multi-agent synchronization and coordination |

## 🛠️ Planning Tools

### Recommended Planner: **LAMA**
- Successfully generates optimal plans for all mission scenarios
- Handles multi-agent coordination effectively
- Robust with complex state spaces

### Alternative: **Fast-Forward (FF)**
- Also suitable for STRIPS domains
- Uses relaxed planning graph heuristic
- May require careful parsing due to strict requirements

## 📋 Key PDDL Elements

### Object Types
- `lander` - Base station for deployment and transmission
- `rover` - Mobile exploration agent with memory buffer
- `waypoint` - Discrete lunar surface locations
- `sample` - Mission objective artifacts
- `astronaut` - Human agent (extended domain only)
- `area` - Internal base locations (extended domain only)

### Core Predicates
- `(empty-memory ?r)` - Rover memory available
- `(has-image ?r)` / `(has-scan ?r)` - Data storage status
- `(deployed ?r)` - Rover deployment status
- `(visible ?w)` - Waypoint visibility for imaging
- `(astronaut-in ?a ?area)` - Astronaut location (extended)
- `(area-of ?area ?l)` - Area-land association (extended)

### Action Flow (Base Domain)
1. **Deploy** → **Move** → **Capture Data** → **Return** → **Transmit**
2. Memory constraint forces sequential data collection/transmission

### Synchronization Constraint (Extended Domain)
- Data transmission requires rover at lander AND astronaut in control room
- Adds temporal coordination between mobile agents

## 🚀 Usage

### Running with LAMA:
```bash
./lama-domain lunar.pddl Mission1.pddl
```

### Running with FF:
```bash
./ff -o lunar.pddl -f Mission1.pddl
```

## 📊 Planning Complexity Analysis

### State Space Growth:
- **Mission1:** Single agent, linear progression
- **Mission2:** Two independent agents, branching factor increases
- **Mission3:** Four interdependent agents, exponential coordination complexity

### Key Design Decisions:
1. **Single-slot memory buffer** enforces sequential data handling
2. **Discrete waypoints** simplify continuous movement for STRIPS
3. **Separate internal/external locations** in extended domain
4. **Astronaut-dependent transmission** models realistic mission constraints

## 📝 Notes for Developers

- All domains are deterministic and use STRIPS semantics
- Typing is implemented for all objects
- Negative preconditions are avoided for FF compatibility
- The extended domain demonstrates progressive complexity addition
- Problem files are designed to test specific coordination challenges

## 🎥 Demonstration
A video demonstration of the planner outputs is available as part of the coursework submission.

## 📚 References
- PDDL 2.1 Specification
- STRIPS planning formalism
- LAMA planner documentation
- Fast-Forward (FF) planner papers

---
**Authors:** Rayyan Ali Ahmed (H00453191), Basil Rehan Siddiqui (H0043528)  
