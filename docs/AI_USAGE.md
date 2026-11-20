# AI Tool Usage — Breeze

## 1. Tools Used

Claude (Anthropic) was my main AI assistant throughout the Breeze project. I used it in two ways:

- **Claude free web interface:** I used the free version at the beginning of the project and whenever it suited the task. In this mode my interaction was simply a conversation: I copied the task description into the chat and asked Claude to approach it with best practices and a Senior Flutter Developer mindset. My internet connection was not stable at that time, so I kept the interaction simple.
- **Claude Code in Claude Desktop, together with the Flutter-Craft plugin:** For later stages I used Claude Code together with Flutter-Craft (https://github.com/vp-k/flutter-craft), an open-source plugin that adds Flutter-specific skills and workflow commands (brainstorming, planning, executing, testing, verification). I also prepared a project context file and a `CLAUDE.md` file to guide Claude's work. I used it as a workflow and guidance tool and adapted its suggestions to this project. For example, I kept a feature-first structure with Cubit instead of a full Clean Architecture domain layer, because that would be over-engineering for this project's scope.

My interaction was conversational and iterative: I discussed problems, asked follow-up questions, evaluated suggestions, and refined the implementation as the project progressed.

## 2. How I Used AI

I used Claude to support different stages of development:

- **Planning:** Understanding the project requirements, breaking the work into manageable steps, and creating an implementation plan.
- **Architecture:** Exploring the project structure, Cubit-based state management, Repository pattern, and separation of responsibilities.
- **Implementation Support:** Getting explanations and code examples for models, API integration, Cubits, and reusable UI components.
- **Debugging:** Investigating development issues, including PowerShell command errors and Flutter implementation problems.
- **Code Review:** Reviewing implementation ideas against the project requirements and discussing potential edge cases.
- **Testing:** Identifying important test scenarios for product calculations, cart quantities, Minimum Order Quantity (MOQ), and stock limits.

## 3. Examples of AI Interactions

The following examples are based on my actual development discussions. They have been shortened and translated where necessary for readability.

### Example 1 — Planning with a Senior Engineering Mindset

**My request:**

> I have this task and want to implement it using best practices. Help me approach it with a Senior Flutter Developer mindset and create a practical implementation plan.

**How AI helped:**

Claude suggested an architecture, package choices, folder structure, important edge cases, implementation priorities, and a development plan.

**My follow-up:**

I asked additional questions to understand and evaluate the suggestions, including whether Bloc was mandatory, whether web support was required, and which part of the project I should start with.

### Example 2 — Understanding Technical Requirements

**My request:**

> Do I have to use Bloc specifically, or are other state management solutions acceptable?

**How AI helped:**

Claude explained the differences between Bloc/Cubit and Riverpod in the context of the project requirements.

**My decision:**

I proceeded with Cubit because it matched the requirements and was suitable for the project's scope.

### Example 3 — Handling API Data and Models

**My approach:**

I shared sample JSON responses from DummyJSON and discussed how the models should handle optional fields, numeric values, reviews, and product information.

**How AI helped:**

Claude suggested null-safe parsing, handling optional product brands, numeric conversion using `num`, and separating product calculations from the UI.

**My evaluation:**

I checked these suggestions against the actual API response structure and the required product behavior before applying the appropriate changes.

### Example 4 — Debugging Environment Issues

**My issue:**

A folder creation command using Bash syntax failed in Windows PowerShell.

**How AI helped:**

Claude identified that the command syntax was incompatible with my shell and provided an equivalent PowerShell solution.

**Result:**

I used commands appropriate for my Windows development environment.

### Example 5 — Cart and Quantity Logic

**My request:**

> Help me implement global Cart and Wishlist Cubits and handle product quantity rules.

**How AI helped:**

Claude suggested shared Cubit instances, quantity constraints based on Minimum Order Quantity (MOQ) and stock, and ways to synchronize cart information across screens.

**My evaluation:**

I reviewed the suggested logic against the project requirements and the expected behavior of the Browse and Product Details screens.

## 4. My Role and Technical Decisions

I used AI as a development assistant, not as a replacement for my own technical decisions.

Whenever a suggestion was unclear or did not fully match the requirements, I asked follow-up questions and evaluated alternative approaches. I also considered the project's scope and existing implementation before making decisions.

Examples of technical decisions discussed during development:

- Choosing Cubit instead of full Bloc to avoid unnecessary boilerplate.
- Using Navigator instead of introducing a more complex routing solution.
- Keeping a feature-first architecture without adding unnecessary Clean Architecture layers.
- Handling search and category filters according to DummyJSON API capabilities.
- Respecting MOQ and stock constraints in cart operations.
- Using request cancellation to prevent outdated search results from affecting the current UI.

## 5. Evaluation of AI Output and Modifications I Made

Overall, the AI suggestions were useful, but they were not always ready to use as-is. I had to review, adapt, and refine many of them to make sure the final implementation met the project requirements.

### Problems I Identified and Addressed

- **Large files that were difficult to maintain:** Some suggested implementations contained too much code in one place and were hard to edit. I reorganized the code into smaller, reusable widgets and classes.

- **Business logic mixed with UI:** Some suggestions placed calculations and state-handling logic inside widgets. I moved responsibilities into Cubits and models so that the UI focuses on displaying state and forwarding user actions.

- **Differences from the Figma design:** Some UI elements did not match the design exactly in terms of spacing, dimensions, colors, and components. I adjusted these details manually by comparing the implementation with Figma and testing the screens on a real device.

- **Dependency management:** I introduced GetIt for dependency injection to centralize the creation of the repository and Cubits, while keeping shared Cart and Wishlist state accessible across screens.

### Other Improvements

I also reviewed and refined the suggested implementations to make sure they followed the project's structure, handled the required product behavior, and stayed consistent with the actual API responses.

**Lesson learned:**

AI can produce an initial implementation quickly, but that does not mean the result is automatically correct or suitable for the project. Reviewing, restructuring, testing, and making independent technical decisions were essential parts of my development process.

## 6. Verification and Learning

I did not rely only on AI-generated suggestions. I reviewed the implementation and checked it against the project requirements.

I also used Flutter's analysis tools and automated tests to verify the application:

- `flutter analyze` — completed with no issues found.
- `flutter test` — all 48 automated tests passed.

The process helped me improve my understanding of architecture, API integration, state synchronization, edge-case handling, and automated testing.

## 7. Conversation History

The full development conversation history with Claude is available as a PDF (Google Drive, view-only):

**[Open conversation history (PDF)](https://drive.google.com/file/d/1_FWWJQx1USXDFbtc5iQEXf3bZDcTnIKu/view?usp=sharing)**

It shows the development discussions, follow-up questions, debugging interactions, and the evolution of technical decisions throughout the project. Note that the history covers conversations from different tools and stages (free web interface and Claude Code), so the style of the conversations varies.

## 8. Final Review Support

Near the end of the project I also used Claude in a separate conversation to review the
finished code against the task requirements and to help prepare the delivery documents
(`README.md`, `docs/TECHNICAL_DECISIONS.md`, and this file). I also used ChatGPT to help
improve the wording of this document. I reviewed and adjusted these documents myself
before submitting.
