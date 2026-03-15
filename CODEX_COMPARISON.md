# AI Codex Comparison Matrix

A detailed comparison of AI coding assistants for benchmarking purposes.

## Quick Comparison

| Feature | Claude Code | Gemini | OpenAI | DeepSeek | Qwen | Aider |
|---------|-------------|--------|--------|----------|------|-------|
| **Status** | ✅ Supported | ✅ Supported | 🚧 Planned | 🚧 Planned | 🚧 Planned | 🚧 Planned |
| **Type** | CLI Tool | Cloud API | Cloud API | Cloud API | Cloud API | CLI Tool |
| **Interface** | Command Line | REST API | REST API | REST API | REST API | Command Line |
| **Authentication** | Session-based | API Key | API Key | API Key | API Key | Config file |
| **Free Tier** | Limited | 1000 req/day | No | Yes | Limited | N/A (self-hosted) |
| **Context Window** | 200K | 1M | 128K | 128K | 128K | Model-dependent |
| **Multi-turn** | ✅ Yes | ✅ Yes | ✅ Yes | ✅ Yes | ✅ Yes | ✅ Yes |
| **Streaming** | ✅ Yes | ✅ Yes | ✅ Yes | ✅ Yes | ✅ Yes | ✅ Yes |

## Detailed Specifications

### 1. Claude Code (Anthropic)

**Status**: ✅ **Implemented**

- **Models**: Claude Opus 4.6, Sonnet 4.5
- **Interface**: CLI (`claude` command)
- **Integration**: Direct CLI execution with JSON output
- **Metrics**:
  - Input/Output tokens
  - Cache creation/read tokens
  - Total cost (USD)
  - Number of turns
  - Duration (ms)
- **Pricing**: Varies by model (~$15-30 per 1M input tokens)
- **Strengths**:
  - Long context (200K)
  - Excellent reasoning
  - Built-in file operations
  - JSON output format
- **Limitations**:
  - Requires Claude Code CLI
  - No free tier for intensive use

**Benchmark Performance** (Original Study):
- Ruby: 73.1s, $0.36, 219 LOC
- Python: 74.6s, $0.38, 235 LOC
- JavaScript: 81.1s, $0.39, 248 LOC

### 2. Gemini (Google)

**Status**: ✅ **Implemented**

- **Models**: Gemini 3.1 Flash-Lite, Flash, Pro
- **Interface**: REST API
- **Integration**: `google-generativeai` via HTTP
- **Metrics**:
  - Prompt token count
  - Candidates token count
  - Cost calculation (custom)
- **Pricing**:
  - Input: $0.25 per 1M tokens
  - Output: $1.50 per 1M tokens
- **Free Tier**: 1000 requests/day, 1500 RPD
- **Strengths**:
  - 1M context window
  - Very cheap (Flash-Lite)
  - Free tier available
  - Fast inference
- **Limitations**:
  - May require more explicit prompts
  - Code extraction from markdown

**Benchmark Performance** (Gemini Repo Study):
- JavaScript: 173.3s, $0.004604, 125 LOC (40/40 passed)
- Python: 167.9s, $0.004907, 138 LOC (39/40 passed)
- Ruby: 136.5s, $0.003918, 154 LOC (29/40 passed)

### 3. OpenAI (GPT-4o, o3, o4-mini)

**Status**: 🚧 **Planned**

- **Models**: GPT-4o, o3, o4-mini
- **Interface**: OpenAI API
- **Expected Integration**:
  - REST API via `net/http` or `openai-ruby`
  - Chat Completions endpoint
  - Function calling support
- **Pricing** (estimated):
  - GPT-4o: $5/$15 per 1M tokens (in/out)
  - o3: Higher (TBD)
  - o4-mini: Lower (TBD)
- **Strengths**:
  - Excellent code generation
  - Strong reasoning (o3)
  - Wide language support
  - Function calling
- **Limitations**:
  - No free tier
  - Context limit (128K for GPT-4o)

**Expected Adapter**:
```ruby
class OpenAICodex < BaseCodex
  API_ENDPOINT = 'https://api.openai.com/v1/chat/completions'
  # Implementation similar to GeminiCodex
end
```

### 4. DeepSeek (V3.2, R1)

**Status**: 🚧 **Planned**

- **Models**: DeepSeek V3.2 (685B), R1 (671B)
- **Interface**: DeepSeek API
- **Pricing**: **$0.27 per 1M tokens** (cheapest powerful model)
- **Strengths**:
  - **Extremely cost-effective**
  - Large parameter count
  - R1 has reasoning capabilities
  - Open source weights available
- **Limitations**:
  - Newer, less established
  - May require self-hosting for best performance

**Why Important**:
- Could be **10-100x cheaper** than Claude/GPT
- Comparable performance on coding tasks
- Open source = reproducibility

### 5. Qwen (3 Coder, 3.5)

**Status**: 🚧 **Planned**

- **Models**: Qwen 3 Coder (480B), Qwen 3.5 (397B)
- **Interface**: Alibaba Cloud API or self-hosted
- **SWE-Bench Scores**:
  - Qwen 3 Coder: 38.7% (Pro)
  - Qwen 3.5: **76.4%** (Verified) - Top performer
- **Strengths**:
  - **Leading SWE-Bench scores**
  - Specialized code models
  - Open source
  - Good multilingual support (Chinese + English)
- **Limitations**:
  - May require Alibaba Cloud account
  - Less documentation in English

**Why Important**: Currently **#1 on SWE-Bench Verified**

### 6. Aider (Open Source)

**Status**: 🚧 **Planned**

- **Type**: CLI Tool (wraps other models)
- **Models Supported**: 75+ (Claude, GPT, DeepSeek, Ollama, etc.)
- **Interface**: Command-line tool + config file
- **Features**:
  - Multi-file editing
  - Git integration
  - Interactive mode
  - Benchmark mode
- **Integration Strategy**:
  - Use Aider's CLI mode
  - Configure with different backends
  - Measure Aider's performance vs direct API calls

**Why Important**:
- Industry-standard tool
- Can test "tool + model" vs "model alone"
- Real-world usage pattern

### 7. Cline (VS Code Extension + CLI)

**Status**: 🚧 **Planned**

- **Type**: CLI Tool + IDE Extension
- **Installations**: 4M+
- **Models**: Multiple (Claude, GPT, etc.)
- **Integration Strategy**:
  - Use CLI mode if available
  - Or headless VS Code automation
  - Measure overhead of IDE integration

### 8. Grok 3 (xAI)

**Status**: 🚧 **Planned**

- **Model**: Grok 3 (314B)
- **SWE-Bench**: 79.4%
- **License**: Open weight
- **Strengths**:
  - Strong coding performance
  - Open weights (reproducibility)
  - Competitive with GPT-4

### 9. Self-Hosted Models

**Status**: 📋 **Future**

Models that can be run locally via Ollama/vLLM:
- Llama 4 Maverick (400B)
- Mistral Large 3 (675B)
- Devstral 2 (123B)
- GLM-4.7 (355B)

**Integration Strategy**:
- Set up Ollama/vLLM server
- Create unified API adapter
- Measure performance vs cloud APIs

## Comparison Dimensions

### 1. Cost Efficiency

| Codex | $/1M Input | $/1M Output | Total Cost (v1+v2, Python) |
|-------|-----------|-------------|----------------------------|
| Gemini Flash-Lite | $0.25 | $1.50 | ~$0.005 |
| DeepSeek V3.2 | $0.27 | $0.27 | ~$0.01 (est.) |
| Claude Opus | ~$15 | ~$75 | ~$0.40 |
| GPT-4o | $5 | $15 | ~$0.15 (est.) |

### 2. Speed

| Codex | Avg Time (v1+v2) | Variance | Notes |
|-------|------------------|----------|-------|
| Claude | 73-81s | Low | Consistent |
| Gemini | 130-170s | Medium | Model-dependent |
| DeepSeek | TBD | TBD | Expected: fast |

### 3. Quality (Test Pass Rate)

| Codex | v1 Pass | v2 Pass | Total (v1+v2) |
|-------|---------|---------|---------------|
| Claude | 100% | 100% | 40/40 (most langs) |
| Gemini JS | 100% | 100% | 40/40 |
| Gemini Python | 97.5% | 97.5% | 39/40 |
| Gemini Ruby | 72.5% | 72.5% | 29/40 |

### 4. Context Window

| Codex | Context Size | Practical Limit |
|-------|-------------|-----------------|
| Gemini | 1M tokens | Very high |
| Claude | 200K tokens | High |
| GPT-4o | 128K tokens | Medium |
| DeepSeek | 128K tokens | Medium |

## Benchmark Methodology

For each codex, we measure:

1. **Generation Time** (seconds)
   - v1: Fresh implementation
   - v2: Extension of existing code
   - Total: v1 + v2

2. **Cost** (USD)
   - Based on actual token usage
   - Input + output tokens
   - Cache usage (if supported)

3. **Code Quality**
   - Test pass rate (%)
   - Lines of code (LOC)
   - Code style/idioms

4. **Reliability**
   - Success rate across trials
   - Variance in performance

## Integration Checklist

For each new codex:

- [ ] Create adapter class extending `BaseCodex`
- [ ] Implement `run_generation()`
- [ ] Implement `version()`
- [ ] Implement `parse_metrics()` (if possible)
- [ ] Add configuration to `codexes.yml`
- [ ] Add API key handling
- [ ] Test dry-run mode
- [ ] Run 1 trial across 3 languages
- [ ] Run 20 trials on Python
- [ ] Document pricing
- [ ] Add to comparison matrix
- [ ] Update ROADMAP.md

## Expected Results

### Hypotheses

1. **Cost**: DeepSeek should be 10-50x cheaper than Claude/GPT
2. **Speed**: Smaller models (Flash-Lite, o4-mini) should be faster
3. **Quality**: Qwen 3.5 should match/exceed Claude on code tasks
4. **Consistency**: Established models (Claude, GPT) more stable

### Key Questions

1. Does **cost correlate with quality**?
   - Or can cheaper models compete?

2. Do **specialized code models** (Qwen Coder, Devstral) outperform general models?

3. How much overhead do **CLI tools** (Aider, Cline) add?
   - Tool performance vs raw API calls

4. Do **open source models** match proprietary ones?
   - Llama, Mistral, DeepSeek vs Claude, GPT

5. Which codex is best for **which language**?
   - Language-specific recommendations

## Future Directions

1. **Multi-model ensembles**: Combine multiple codexes
2. **Agentic workflows**: Test tools like Goose with MCP
3. **Fine-tuning**: Custom models for MiniGit task
4. **Larger benchmarks**: Scale beyond MiniGit
5. **Real-world tasks**: Beyond synthetic benchmarks

---

**Last Updated**: 2026-03-15
