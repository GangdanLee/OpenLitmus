# Contributing to OSHEF

Thank you for your interest in contributing! Here's how you can help.

## Areas for Contribution

### High-Value
- **Scoring calibration** — Evaluate more projects using OSHEF and share your scoring data to help calibrate the anchors
- **Security checklist expansion** — Add security checks specific to certain frameworks (Django, Rails, Spring, etc.)
- **Automated tooling** — Scripts or tools that automate data collection for specific indicators

### Medium-Value
- **Technology-specific adaptations** — Go, Rust, Java, etc. equivalents for Python-focused checks
- **Documentation improvements** — Typo fixes, clearer explanations, additional examples
- **Translations** — README and framework docs in additional languages

## How to Contribute

1. **Fork** this repository
2. **Create a branch** for your changes (`git checkout -b feature/my-improvement`)
3. **Make your changes** with clear commit messages
4. **Submit a Pull Request** with a description of what you changed and why

## Guidelines

- Keep the framework **focused on static analysis** — no runtime requirements
- All scoring anchors should be **data-driven** with clear thresholds
- New checks should include the **tool/command** to run and **what to look for**
- Use English for code and primary documentation; Chinese translations welcome

## Reporting Issues

Use the issue templates:
- **Bug Report** — For inaccurate scoring anchors or broken tooling
- **Feature Request** — For new indicators, dimensions, or tool support
