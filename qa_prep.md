# Defense Q&A Preparation

## Core Technical Questions
- Scalability of graph construction: Use incremental entity extraction; batch merges; discuss O(N) chunk pass + hash map for entity nodes.
- Temporal conflict resolution: Timestamps prioritized; later node supersedes earlier; fallback manual review if same timestamp.
- Novelty vs GraphRAG: Emphasis on enterprise schema integration + temporal nullification + MCP standardization.
- Hallucination mitigation: Constrained tool calls; schema validation; evidence set assembly before generation.
- Benchmark validity: Synthetic enterprise corpus with injected update/nullification patterns; acknowledge need for public dataset.

## Design / Architecture
- Why Weaviate: Hybrid search + schema refs + modular scaling; alternatives (Neo4j + separate vector store) increase integration complexity.
- Choice of agent paradigm: ReAct provides reasoning trace; could evolve to planner + verifier multi-agent.
- Entity extraction reliability: LLM few-shot + heuristic normalization; plan for statistical NER fine-tuning.

## Evaluation Methodology
- Metrics definitions: Retrieval accuracy (contains correct evidence), Answer correctness (thresholded quality), Improvement factor (relative delta).
- Ablation interpretation: Show each component's isolated contribution without compounding (graph refs, temporal ordering, hybrid search).
- Threshold selection: Youden index balancing precision/recall on validation subset.

## Limitations / Risks
- Residual hallucinations: Without strict grounding on every token; future verification agent.
- Over-merging entities: Mitigated by keeping provenance links; propose similarity threshold tuning.
- Privacy / ACL: Currently conceptual layer; integration requires pre-filtered query planning.

## Future Work / Impact
- Multi-agent consistency: Planner + checker to ensure temporal coherence.
- Benchmark release: Encourage reproducible evaluation in enterprise settings.
- Integration into decision support: Reduced risk of outdated policy use.

## Potential Edge Cases
- Missing updates: Graph traversal returns outdated node; answer includes uncertainty phrase.
- Conflicting simultaneous updates: Present both; highlight need for manual resolution.
- Very sparse graph: System gracefully degrades to hybrid vector-only retrieval.

## Robotics / Control Analogies
- State estimation: Graph as latent world model; updates akin to sensor fusion corrections.
- Closed-loop planning: Agent traversal refines evidence (feedback) before action (answer generation).

## Strategic Answer Patterns
- Start with affirmative statement of capability.
- Reference concrete metric ("60% vs 14–34% retrieval").
- Brief mechanism ("multi-hop with temporal ordering").
- Future enhancement ("scales via incremental ingestion").

## Quick Data Points to Memorize
- Retrieval accuracy gain: ~2–4× over baselines.
- Correct answers: 61% vs baselines below 35%.
- Key components: Schema, Graph, Agent traversal, MCP tools.

## Closing Reinforcement
Emphasize reliability and currency of information as differentiator over generic RAG.
