# Telegram MCP Project Guidelines

## Project Overview
This is a Telegram integration for Claude via the Model Context Protocol (MCP), forked from chigwell/telegram-mcp. The project uses Telethon for Telegram API access and provides comprehensive tools for chat management, messaging, and user interactions.

## Coding Standards

### Required tooling
| purpose          | tool                           |
|------------------|--------------------------------|
| deps & venv      | `uv`                           |
| lint & format    | `ruff check` · `ruff format`   |
| static types     | `ty`                           |
| tests            | `pytest -q`                    |

### Rules
1. ≤ 50 code lines / function  
2. Cyclomatic complexity ≤ 8  
3. ≤ 5 positional params, ≤ 12 branches, ≤ 6 returns  
4. 100‑char line length  
5. Ban relative ("..") imports  
6. Google‑style docstrings on every public symbol  
7. Tests live beside code

### Framework Preferences
- **Package manager**: uv (Astral's tool)
- **Formatter/Linter**: ruff (Astral's tool)
- **Type checker**: ty (Astral's tool)

## Project-Specific Information

### Current State
- Python 3.11 preferred
- Uses MCP (Model Context Protocol) for Claude integration
- Telethon for Telegram API
- Docker support available
- No test suite currently exists

### Known Issues
- Type checking with `ty` shows 16 errors (mostly related to optional types and Telethon API)
- Some Telethon methods may be version-specific (e.g., SearchGifsRequest)
- File-related tools have been removed due to MCP environment limitations
- Output truncation is set to 100K chars (optimized for Anthropic's latest models)

### Common Commands
```bash
# Install dependencies
uv sync

# Run with dev dependencies
uv sync --all-extras

# Format code
uv run ruff format

# Check linting
uv run ruff check --fix

# Type check
uv run ty check

# Run the main script
uv run python main.py

# Generate session string
uv run python session_string_generator.py
```

### Environment Variables
Required in `.env`:
- `TELEGRAM_API_ID`: Your Telegram API ID
- `TELEGRAM_API_HASH`: Your Telegram API hash  
- `TELEGRAM_SESSION_STRING`: Session string (preferred)
- `TELEGRAM_SESSION_NAME`: Session file name (alternative)

### Architecture Notes
- Main entry point: `main.py`
- Uses FastMCP for tool registration
- Comprehensive error handling with user-friendly messages
- Session management supports both string and file-based sessions
- Logging to `mcp_errors.log` for debugging

### Future Improvements
- Add comprehensive test suite (pytest)
- Fix remaining type errors
- Consider breaking main.py into smaller modules (currently ~2300 lines)
- Add more robust input validation
- Implement rate limiting for API calls