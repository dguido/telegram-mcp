# Telegram MCP TODO List

## Completed ✅
1. **Switch to main branch and pull latest** (high priority)
2. **Fix Issue #16: Add output size limits** (high priority)
   - Added truncate_output() helper function
   - Applied to 7 functions that return large outputs
   - Quick fix to prevent token overflow with smaller models

## In Progress 🔄
3. **Fix Issue #10: Enable Docker volume persistence** (high priority)
   - Need to add VOLUME directive to Dockerfile
   - Uncomment volume mount in docker-compose.yml
   - Update README with instructions

## Pending 📋
4. **Test changes** (high priority)
   - Verify output truncation works correctly
   - Test Docker volume persistence

5. **Create PRs for both fixes** (medium priority)
   - PR for output size limits (Issue #16)
   - PR for Docker volume persistence (Issue #10)

## Future Improvements 🚀

### Output Limits Enhancement
6. **Improve output limits: Add proper pagination to all list functions instead of truncation** (medium priority)
   - Current truncation is a band-aid solution
   - Implement page/page_size parameters consistently
   - Better UX than silent truncation

7. **Make output limits configurable via env vars for different model sizes** (low priority)
   - Different models have different token limits
   - Allow users to configure based on their LLM
   - e.g., TELEGRAM_MCP_MAX_OUTPUT_CHARS=50000

8. **Add metadata about truncation** (low priority)
   - Show "Showing 50 of 500 contacts" when truncating
   - Help users understand when data is incomplete
   - Provide hints about using pagination

## Analysis: Output Limits Implementation

### Current Implementation
- Added 30K character limit (≈7500 tokens)
- Truncates at newlines when possible
- Shows "... [Output truncated]" indicator

### Pros
- Non-breaking change
- Prevents complete failure with small models
- Clear truncation indicator

### Cons
- Arbitrary limit not based on specific models
- Silent data loss possibility
- No pagination alternative
- Inconsistent - some functions have limits, others don't

### Better Long-term Solution
- Implement proper pagination across all list functions
- Make limits configurable per model
- Return metadata about total results
- Consider streaming responses for very large datasets