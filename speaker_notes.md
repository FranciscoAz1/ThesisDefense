# Speaker Notes: MSc Thesis Defense
## Enhancing Semantic Search with Retrieval-Augmented Generation and Agentic AI

**Presenter:** Francisco Azeredo  
**Date:** Defense Presentation  
**Total Duration:** less than 20 minutes (adjust per slide timing)

---

## Slide 1: Title Page
**Purpose:** Opening frame  
**Script:**
- (Greet committee) "Good morning/afternoon. Thank you for the opportunity to present my thesis on enhancing semantic search using RAG and agentic AI."
- "I'm Francisco Azeredo, advised by Professor Sérgio Guerreiro and Engineer Filipe Mendes from Link Consulting."

**Transition:** "Let's begin with the structure of this presentation."

---

## Slide 2: Presentation Structure
**Purpose:** Set roadmap and expectations  
**Script:**
- "I'll walk through six main sections: motivation and problem context, objectives, the architecture and components we developed, related work for positioning, evaluation results, and finally conclusions with future directions."

**Timing:** ~20 seconds  
**Transition:** "First, let me establish why this work matters in enterprise environments."

---

## Slide 3: Enterprise Information Challenges
**Purpose:** Establish pain points and business criticality  
**Script:**
- "Enterprises depend on accurate, current information for high-stakes decisions—project approvals, compliance, operational governance."
- "The cost of getting it wrong is substantial: regulatory violations, project failures, financial losses."
- "Yet professionals spend significant time manually searching, reading, and analyzing multiple documents. They face high cognitive load verifying dependencies."
- "Critical risk: decisions may rely on superseded or nullified information."
- "Even modern semantic search systems fail here—they cannot guarantee information currency or detect contradictions across documents."

**Transition:** "Let me ground this in the specific context of Edoclink Enterprise."

---

## Slide 4: Context: Edoclink Enterprise
**Purpose:** Show the structured environment and opportunity  
**Script:**
- "Edoclink is a document management platform that organizes information with structured workflows and business rules."
- "It supports evolution from simple ad-hoc processes to complex workflow configurations, enabling end-to-end digitalization."
- "Key features include document lifecycle management, collaborative work, and ERP integration—widely used in public sector and enterprises with rich, complex processes."
- "The thesis opportunity: leverage this rich organizational structure to enhance semantic search and retrieval accuracy."

**Transition:** "A concrete example illustrates the problem better."

---

## Slide 5: Problem Illustration
**Purpose:** Visual anchor for temporal dependency risk  
**Script:**
- "This slide illustrates the core challenge: when information evolves over time, naive retrieval systems retrieve early dramatic reports but miss critical updates."
- "The risk is getting wrong, potentially dangerous answers because dependencies aren't tracked."

**Timing:** ~30 seconds  
**Transition:** "Let me walk through a specific timeline."

---

## Slide 6: Problem: Example Scenario
**Purpose:** Emphasize temporal ordering and supersession  
**Script:**
- "Timeline: In January, conflict escalation reported—document A."
- "In March, ceasefire agreement reached—document B supersedes A's implications."
- "In April, someone queries: 'What is the current status of the War in Ukraine?'"
- "The risk: naive retrieval ranks the dramatic January declaration higher, ignores the ceasefire, and produces an outdated answer."
- "Core challenge: we must capture and reason over document dependencies and temporal relationships."

**Transition:** "This reflects a broader problem in information retrieval."

---

## Slide 7: Problem
**Purpose:** Summarize the gap  
**Script:**
- "Current search methods don't account for information interdependencies."
- "GraphRAG ideas are emerging in research, but enterprise organizational schemas remain underused."
- "We need to bridge semantic retrieval with explicit relational structure."

**Transition:** "This leads directly to our objectives."

---

## Slide 8: Objectives Overview
**Purpose:** High-level goals  
**Script:**
- "Four main objectives:"
- "First, represent enterprise document structure and relations"
- "Second, detect updates and contradictions across documents."
- "Third, make it enterprise-ready: standardized, easy to implement with emerging frameworks, and scalable to large repositories."
- "Fourth, rigorously evaluate efficiency and quality—understand the cost-benefit trade-offs."

**Transition:** "Breaking these into concrete technical targets."

---

## Slide 9: Objective Details
**Purpose:** Concrete actionable targets  
**Script:**
- "Schema design covering workflows, entities, and metadata."
- "Graph construction with entity merging and cross-references."
- "Agent traversal supporting multi-hop and temporal ordering."
- "MCP tools providing validated queries and reference following."
- "Evaluation measuring retrieval accuracy and answer quality."

**Transition:** "Now let's look at the architecture."

---

## Slide 10: Architecture Overview
**Purpose:** Pipeline framing  
**Script:**
- "We developed three independent components for each processing stage:"
- "First, insertion and indexing—automatic knowledge graph construction from documents."
- "Second, query techniques—ranging from simple semantic search to graph-aware retrieval."
- "Third, generation—providing context to agents or LLMs for readable, grounded outputs."
- "This modularity allows each layer to evolve independently."

**Timing:** ~30 seconds  
**Transition:** "Starting with knowledge graph construction."

---

## Slide 11: Knowledge Graph Construction
**Purpose:** Process explanation  
**Script:**
- "Three main steps:"
- "Extract entities and relationships from documents using LLM-guided prompts."
- "Merge nodes with matching entities to normalize the graph."
- "Create relationship edges based on entities in the same chunk."

**Transition:** "Once we have the graph, we need flexible query strategies."

---

## Slide 12: Query Techniques
**Purpose:** Latency-depth trade-off spectrum  
**Script:**
- "Query techniques range from lowest to highest latency:"
- "Start with semantic, BM25, and hybrid queries for speed."
- "Add query reformulation—extracting entities and relationships from the query itself to guide graph retrieval."
- "Finally, ReAct agent queries using our MCP server for complex multi-hop reasoning."
- "This diagram shows the MiniQuery flow—keyword extraction, context construction, answer generation."

**Transition:** "How do we configure the agent?"

---

## Slide 13: Agent Configuration
**Purpose:** Agent grounding and constraints  
**Script:**
- "Three key configurations:"
- "First, the agent is instructed to be a document assistant connected to a Weaviate database, basing all answers on retrieved documents and responding concisely with sources."
- "Second, it's equipped with tools through an MCP server that translates natural language to valid GraphQL queries."
- "Third, curated collection descriptions guide the agent in selecting the right data source."

**Timing:** ~45 seconds  
**Transition:** "Let me explain the MCP server bridge."

---

## Slide 14: MCP Server (Weaviate Bridge)
**Purpose:** Tool interface mechanics  
**Script:**
- "The MCP server provides a standard tool interface for agents."
- "It performs validated, schema-aware queries—preventing silent schema errors."
- "Key tools: weaviate-query for hybrid search, weaviate-origin which appends object references described by their relationships, and weaviate-follow-ref which enables agentic graph traversal by following references and repeating the origin operation."
- "This standardization makes agent pipelines reproducible and debuggable."

**Transition:** "Now let's evaluate this system."

---

## Slide 15: Evaluation Questions
**Purpose:** Frame evaluation scope  
**Script:**
- "Three critical questions guide our evaluation:"
- "Does MiniRAG successfully capture document interdependency?"
- "Does the model choice for retrieval matter?"
- "How much can an agentic system improve retrieval and answer generation compared to naive approaches?"

**Timing:** ~20 seconds  
**Transition:** "First, the temporal interdependency test."

---

## Slide 16: MiniRAG: Temporal QA Interdependencies (KEY SLIDE - 90 sec max)
**Purpose:** Compare approaches under temporal dependency pressure  
**Script:**
- "Temporal QA dataset where facts evolve—correctness depends on capturing updates."
- "Objective: does MiniRAG's entity profiling improve Token Recall over naive RAG?"
- "Results: Naive RAG 43-44%. MiniRAG with small model (Qwen2.5-3B) underfits at 38%."
- "Key finding: MiniRAG jumps to 68.4% with stronger models (gpt-4o-mini), while naive stays at 43%."
- "The gap widens with model capacity—this approach scales with reasoning capability."
- "Conclusion: Promising for temporal corpora but model-capacity constrained. Cost-quality tradeoff requires larger models."

**Timing:** ~60 seconds (strict)

**Transition:** "Beyond temporal dependency, does model choice matter more broadly?"

---

## Slide 17: Does the model matter?
**Purpose:** Demonstrate agentic uplift  
**Script:**
- "Looking at document retrieval rates across approaches:"
- "Agentic RAG achieved 60.4% correct document retrieval—that's 2 to 4 times better than naive baselines which ranged from 13-22%."
- "For answer correctness, 61% versus teens for naive approaches."
- "The iterative planning, retrieval, observe-and-reflect loop makes the critical difference."
- "This validates that model architecture—specifically agentic reasoning—dramatically impacts quality."

**Transition:** "Can this scale across multiple data sources?"

---

## Slide 18: Multi-Collection Retrieval
**Purpose:** Robustness across heterogeneous sources  
**Script:**
- "We tested the agentic ReAct system across multiple Weaviate collections—synthetic company documents and the LiHua temporal dataset."
- "Results show the agent correctly selects collections and handles format variation."
- "Improvement of 2 to 3 times across strategies compared to single-collection baselines."
- "The curated collection descriptions guided the agent to make more informed semantic queries."
- "This demonstrates robustness: the system adapts to diverse organizational structures without code changes."

**Transition:** "Can we optimize storage and reduce noise?"

---

## Slide 19: Summarization, compressing storage
**Purpose:** Preprocessing impact on retrieval  
**Script:**
- "We tested two summarization approaches: LexRank—extractive—and BART—abstractive."
- "LexRank improved retrieval rate from 13.8% to 33.6%, with token recall rising from 19.1% to 29.5%."
- "BART increased retrieval rate to 17.8%, but token recall collapsed to 3% and Jaccard to 11%."
- "Why? Abstractive summarization paraphrases, losing critical lexical anchors—the exact terms needed for precise matching."
- "Extractive methods preserve the original text, maintaining grounding."
- "Takeaway: For QA systems requiring factual grounding, prefer extractive summarization. It reduces noise effectively without sacrificing answer accuracy. Thresholds selected via Youden's J maximize sensitivity + specificity."

**Transition:** "Let me show a real workflow traversal case."

---

## Slide 20: Integration for Edoclink's workflow organization
**Purpose:** Demonstrate multi-hop reasoning in action  
**Script:**
- "This use case shows cross-reference navigation in a company workflow database organized by our schema."
- "The agent receives the question: 'How is the war on Russia and Ukraine?'"
- "It doesn't retrieve one large document hoping the answer is there. Instead, it hops: files, then stages, then flows, then entities—reasoning at each step."
- "This multi-hop discovery enables storing information in small, focused snippets rather than huge monolithic documents."
- "Why does this matter? Limited context windows and context drift in LLMs make large documents problematic. Small, structured retrieval with reasoning is more reliable."
- "The diagram shows the agent's path—structured traversal guided by cross-references."

**Transition:** "What does the final answer look like?"

---

## Slide 21: Final Answer
**Purpose:** Illustrate grounded output quality  
**Script:**
- "The final answer: 'It remains an active, violent conflict.'"
- "Grounding: The agent found a matched stage in the workflow tied to a July 2024 report—'Drone attack hits military base.' Excerpt describes drone strike, significant damage and casualties."
- "Interpretation shows continued strikes on military targets with ongoing casualties."
- "Notice: explicit evidence, timestamps, and clear interpretation—reducing hallucination risk with audit trails."

**Timing:** ~45 seconds

**Transition:** "How does this relate to existing work?"

---

## Slide 22: Related Work
**Purpose:** Position in landscape  
**Script:**
- "Several systems tackle adjacent problems:"
- "Google NotebookLM focuses on personal, source-grounded assistants over curated notes, producing footnoted syntheses."
- "Perplexity AI provides web-grounded conversational search with inline citations and multi-document aggregation."
- "Vector databases like Weaviate, Qdrant, and Milvus supply embedding infrastructure but not reasoning."
- "Gap: Multi-hop agentic retrieval over semi-structured enterprise information organized in ruled workflow configurations—platforms like Edoclink."

**Transition:** "What differentiates our approach?"

---

## Slide 23: Comparison to Prior Approaches
**Purpose:** Articulate differentiators  
**Script:**
- "Our solution—Multi-Hop Agentic Retrieval—integrates schema-driven traversal with agent reasoning."
- "It standardizes graph access through the MCP server—reproducible, debuggable tool interfaces."
- "Focus is on enterprise interdependency reliability, not just semantic similarity."
- "We move from opaque embedding proximity to explainable structural reasoning with audit trails."

**Transition:** "Let's summarize the conclusions."

---

## Slide 24: Conclusions
**Purpose:** Main takeaways  
**Script:**
- "Four key conclusions:"
- "Graph-aware reasoning prevents outdated answers by capturing temporal supersession and dependencies."
- "Structure-aware retrieval leverages cross-references and metadata for precision—not just embeddings."
- "Well-instructed agents with schema-aware tools guide retrieval and sourcing effectively."
- "Tool standardization through MCP enables reproducible agent pipelines across different data sources."

**Transition:** "Of course, there are limitations."

---

## Slide 25: Limitations
**Purpose:** Acknowledge constraints transparently  
**Script:**
- "Several constraints:"
- "Scale was limited by compute and budget—couldn't test largest models extensively."
- "No public benchmark exists for workflow-organized information—significant construction overhead for synthetic datasets."
- "The NLP ecosystem evolves rapidly—these conclusions are time-bound to current model generations."
- "Model and embedding updates can change retrieval behavior—version pinning is critical for reproducibility."
- "RAG and agent frameworks evolve quickly—we must pin versions, datasets, prompts, and evaluation protocols."

**Transition:** "This points to exciting future work."

---

## Slide 26: Future Work
**Purpose:** Roadmap and next steps  
**Script:**
- "Several directions:"
- "Integration with Edoclink's production platform, including access control layers."
- "Beta testing multi-hop agentic retrieval in real-world enterprise settings with live feedback."
- "Releasing a public benchmark for structure-aware retrieval to enable reproducible research."
- "Implementing caching for latency reduction in multi-hop retrieval—avoid redundant traversals."
- "Exploring advanced agentic workflows: better GraphRAG, relevant versus outdated information management, chatbot memory."
- "Developing more MCP servers for other enterprise applications—standardizing tool interfaces."

**Transition:** "Thank you."

---

## Slide 27: Thank You
**Purpose:** Close and invite questions  
**Script:**
- "Thank you for your attention."
- "I'm happy to answer questions and dive deeper into graph traversal mechanics, agent cost trade-offs, evaluation methodology, or implementation details."
- "Questions?"

---

## General Presentation Tips

### Timing Guidance (Target: <20 minutes)
- **Total duration:** 18-19 minutes (strict 20-min limit)
- **Introduction (Slides 1-7):** ~5 minutes (45 sec/slide avg)
- **Architecture (Slides 8-14):** ~5 minutes (45 sec/slide avg)
- **Evaluation (Slides 15-21):** ~6 minutes (50 sec/slide avg, key results)
- **Context & Conclusions (Slides 22-27):** ~3 minutes (30 sec/slide avg)
- **Buffer:** 1 minute for transitions/questions during

### Delivery Notes
- **Pace:** Speak clearly; pause after key points (e.g., retrieval rate improvements).
- **Emphasis:** Slow down when presenting numbers—"sixty point four percent"—to let them register.
- **Eye contact:** Distribute attention across committee members.
- **Anticipate questions:** Be ready to expand on:
  - Cost analysis (per-query breakdown)
  - Why Token Recall is the primary metric
  - Schema design choices
  - MCP server implementation details
  - Comparison to LangGraph or other agent frameworks

### Technical Depth Adjustments
- If committee signals interest in implementation: expand on GraphQL generation, schema validation logic.
- If focus is on evaluation: emphasize Youden's J statistic, threshold selection rationale, metric trade-offs.
- If business-focused: stress cost-benefit analysis, scalability to millions of documents, ROI for enterprises.

---

**End of Speaker Notes**
