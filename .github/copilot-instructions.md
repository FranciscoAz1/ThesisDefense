# Copilot Instructions: Thesis Defense Presentation

## Project Overview
This is a **LaTeX Beamer presentation** for a Master's thesis defense at Instituto Superior Técnico (IST). The thesis focuses on **enhancing semantic search with RAG and agentic AI** in enterprise settings, specifically addressing temporal dependencies and document interdependencies through knowledge graph construction and multi-hop agent traversal.

## Architecture & Key Components

### Dual-Workspace Structure
- **Presentation workspace** (`Final/`): Defense slides, speaker notes, Q&A prep
- **Thesis workspace** (`IST-UL-MSc-Thesis-Enhancing-Semantic-Search-/`): Full thesis document with detailed chapters
- These are **separate but related** - presentation summarizes thesis content; avoid mixing edits

### Critical Files
- `presentation.tex`: Main Beamer document using custom IST theme
- `speaker_notes.md`: Per-slide speaking script with timing guidance (max 20 min defense)
- `defense_plan.md`: Tactical timing breakdown and slide priorities
- `qa_prep.md`: Anticipated questions with prepared answers and key metrics
- `tables_and_code/*.tex`: LaTeX table fragments imported via `\input{}` - edit these separately
- `beamertheme*.sty`: IST corporate identity theme files - **do not modify** unless explicitly requested

### Content Source Files
When user asks to update slides based on thesis content, reference:
  - `Chapters/Thesis-MSc-Abstract-EN-Abstract.tex`: English abstract
  - `Chapters/Thesis-MSc-Abstract-EN-KeyWords.tex`: English keywords
  - `Chapters/Thesis-MSc-Abstract-PT-PalavrasChave.tex`: Portuguese keywords
  - `Chapters/Thesis-MSc-Abstract-PT-Resumo.tex`: Portuguese abstract
  - `Chapters/Thesis-MSc-Acknowledgments.tex`: Acknowledgments
  - `Chapters/Thesis-MSc-Acronyms.tex`: Acronyms
  - `Chapters/Thesis-MSc-Chapter_1.tex`: Introduction
  - `Chapters/Thesis-MSc-Chapter_2.tex`: Background and Related Work
  - `Chapters/Thesis-MSc-Chapter_3.tex`: Problem Statement and Motivation
  - `Chapters/Thesis-MSc-Chapter_4.tex`: System architecture (MiniRAG, Weaviate MCP server, knowledge graph construction)
  - `Chapters/Thesis-MSc-Chapter_5.tex`: Results and evaluation (temporal QA, naive vs agentic RAG, metrics)
  - `Chapters/Thesis-MSc-Chapter_6.tex`: Conclusions and Future Work
  - `Chapters/Thesis-MSc-AppendixA.tex`: Appendix A
  - `Chapters/Thesis-MSc-AppendixB.tex`: Appendix B
  - `Chapters/Thesis-MSc-Glossary.tex`: Glossary
These chapters contain the authoritative technical details for slide content.

## Build System

### Standard Build Commands
```powershell
# Quick compile (most common)
make

# Full build with bibliography
make all

# Clean auxiliary files
make clean

# Remove all generated files including PDF
make veryclean
```

**Build tool**: `pdflatex` (NOT `xelatex` or `lualatex`)  
**Working directory**: Always `Final/` folder for presentation

### Common Build Issues
- **Missing references**: Run `make all` instead of `make` to process bibliography
- **Stale aux files**: Run `make clean` then `make` if slides aren't updating
- **Image paths**: Images use relative paths - check `figures/` and `Images/` directories

## Project-Specific Conventions

### Slide Content Style
- **Concise bullets**: 3-7 words per bullet; avoid full sentences in itemize
- **Emphasis markers**: Use `\textbf{}` for key terms, not `\emph{}`
- **Metrics presentation**: Always include comparison context (e.g., "60.4% vs 13.8% baseline")
- **Table integration**: Reference external `.tex` files in `tables_and_code/` via `\input{}`

### Frame Structure Patterns
```latex
\begin{frame}{Title}
\textbf{Context Header:} Brief setup sentence
\vspace{0.4em}
\textbf{Core Point:} Main message
\begin{itemize}
  \item Bullet structure
\end{itemize}
\textbf{Conclusion:} Takeaway statement
\end{frame}
```

### Technical Terminology (Use Consistently)
- **MiniRAG**: Knowledge graph approach with entity profiling (not "mini RAG" or "Mini-RAG")
- **Token Recall**: Primary temporal accuracy metric (prioritize over BERT/Jaccard in explanations)
- **Agentic RAG**: ReAct agent with multi-hop retrieval (not "agent-based RAG")
- **Weaviate MCP Server**: Model Context Protocol bridge to Weaviate database
- **Cross-references**: Traversable edges in Weaviate schema (not "relationships" or "links")

### Visual Element Guidelines
- **Diagrams**: Located in `Images/` (workflow diagrams, UML, sequence diagrams)
- **Figures**: Located in `figures/` (logos, IST branding)
- **Image width**: Use `width=0.5\linewidth` to `width=0.8\linewidth` for diagrams
- **Captions**: Include figure context even for presentations (required by IST standards)

## Key Research Concepts (For Content Accuracy)

### Core Thesis Contributions
1. **Schema-aware knowledge graph** construction from enterprise documents (Fluxo/Etapa/Entidade/Pasta/Ficheiro/Metadados classes)
2. **MCP server standardization** for agent-database communication with schema validation
3. **Multi-hop agentic retrieval** demonstrating 2-4× improvement over naive RAG (60.4% vs 13.8-22.5%)
4. **Temporal dependency capture** through entity profiling (effectiveness scales with model capacity)

### Evaluation Framework
- **Primary metric**: Token Recall (44% naive, 38% MiniRAG with Qwen2.5-3B, 68.4% MiniRAG with gpt-4o-mini)
- **Dataset**: LiHua-World (temporal QA), synthetic company documents (1000 files)
- **Threshold optimization**: Youden's J statistic for classification boundaries
- **Cost-quality tradeoff**: Agentic RAG is ~27.6× more expensive but 4.4× more accurate

### Important Limitations (Acknowledge When Relevant)
- Budget constraints prevented testing with largest models (GPT-4/5 class)
- No public benchmark for workflow-organized information (synthetic corpus used)
- Extractive summarization (LexRank) outperforms abstractive (BART) for grounding-sensitive QA
- Small models (Qwen2.5-3B) underfit temporal profiling tasks

## Common Workflows

### Editing Slide Content
1. Locate frame by title in `presentation.tex`
2. Check if content references thesis chapters for source truth
3. Maintain IST Beamer formatting (itemize structure, spacing, emphasis)
4. Test compile with `make` before committing changes

### Adding New Slides
- Insert after existing `\section{}` declaration or create new section
- Follow frame structure pattern (see above)
- Add corresponding entry to `speaker_notes.md` with timing estimate
- Update total slide count in `defense_plan.md` if affecting timing

### Creating Tables
1. Create new `.tex` file in `tables_and_code/`
2. Use `\begin{tabular}` with `\hline` separators (see existing tables as templates)
3. Import in presentation via `\input{tables_and_code/filename.tex}`
4. Keep table data and presentation frame separate for easier editing

### Updating Speaker Notes
- Organize by slide title (use `## Slide X: Title` headers)
- Include: Purpose, Core script (3-5 sentences), Transition cue
- Add timing guidance if slide is content-heavy
- Reference specific metrics/numbers to memorize

## Integration Points

### External Dependencies
- **Beamer class**: Standard LaTeX installation required
- **IST theme**: Custom theme files (`beamertheme*.sty`) in project root
- **BibTeX**: Bibliography processing for references (run `make all`)
- **PowerShell**: Default shell for build commands (use `;` not `&&` for command chaining)

### Cross-Document References
- Presentation slides **summarize** thesis chapters - check source chapters for accuracy
- `student_profile.md`: User context for general assistance
- `.github/agents/presentation.agent.md`: Specialized agent configuration for this project

## Debugging Guidance

### LaTeX Compilation Errors
- Check `.log` file for detailed error messages
- Common issues: missing `\end{frame}`, unmatched braces `{}`, invalid image paths
- IST theme errors: Ensure all `beamertheme*.sty` files present in project root
- For bold text issues, verify `\textbf{}` usage instead of `extbf{}`

### Content Discrepancies
- If slide content conflicts with thesis: thesis chapters are authoritative source
- Check chapter attachments for exact phrasing of technical concepts
- Verify metrics/numbers against results tables in Chapter 5

### Presentation Flow Issues
- Reference `defense_plan.md` for timing allocation and slide priorities
- Use `speaker_notes.md` to ensure smooth transitions between slides
- High-density slides (results, architecture) need slower pacing - note in script

## Best Practices for This Project

1. **Always compile after edits** - run `make` to catch LaTeX errors immediately
2. **Preserve IST branding** - don't modify theme files or logo placement
3. **Match thesis precision** - technical terms and metrics must align with source chapters
4. **Maintain speaking script** - update `speaker_notes.md` when changing slide content
5. **Consider defense timing** - 20-25 min total; budget ~1-2 min per content slide
6. **Use existing patterns** - reference similar slides for formatting consistency
7. **Test table imports** - ensure `\input{}` paths work after creating new table files

## Quick Reference: File Responsibilities

| File | Purpose | Edit Frequency |
|------|---------|----------------|
| `presentation.tex` | Slide content | High - main working file |
| `speaker_notes.md` | Defense script | Medium - sync with slides |
| `defense_plan.md` | Timing strategy | Low - finalize before defense |
| `qa_prep.md` | Q&A preparation | Medium - add anticipated questions |
| `tables_and_code/*.tex` | Data tables | Low - generated from results |
| `beamertheme*.sty` | Theme files | Never - IST standard |
| `Makefile` | Build automation | Never - working configuration |

---

**Last Updated**: Following thesis content finalization  
**Target Audience**: AI coding assistants (Copilot, Claude, Cursor)  
**Maintained By**: Francisco Azeredo (thesis author)
