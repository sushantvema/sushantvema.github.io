ai_profile_enrichment.md
	Enriched Profile: Multi-step RAG process
		Components
			1. Intelligently sampled cippus (post) texts
				Subset of embedded cippus data based on a union of semantic searches
				TODO: Incorporate dates (cippus.time_posted)
			2. network_account_id (user level) profile information
				Biography / Headline
				TODO: Account type (platform)
		Application
			1. Influencer Sourcing / Discovery
				Brand Affinity Analysis
				Lexical and/or semantic search on enriched profile summaries ('biographies')
				Keyword-search or metadata filtering on extracted tags from JSON
			2. Influencer Vetting and Quality Assurance
			3. Sources (citations)
		Development
			1. Data Pipelines
				1. Pull data from raw bucket layer, populate working index
				2. Decide on a schema
					Mack spreadhsaset
					Anything else that comes to mind
				3. Fetch similar posts and generate summarization
					Add to delta table
					Timeline: 2 weeks
				4. Sagar: Pick up summarization and add to vector index of network bio
					Unity Catalog
					{"network_bio_object" : "summarization_details" : {embedding}}
					Timeline: 3 weeks
				5. Evaluation / scoring
			2. Vector search across cippus text embeddings
			3. Self-hosted open-source models
				Llama3
					Llama3 70b Instruct
					Llama3 70b base
			4. Databricks workflows
				Jobs, nodes, DAGs, orchestration
			5. Evaluation Methodology
				Alignment
					How well do the response formats align with human values and preferences for our operations team?
				Case coverage
					Do we get all of the fields that we want?
		Production
			Calibration
				Intelligently updating summaries on a timely basis
				Find a critical threshold for number of posts so that once account has surpassed threshold, no need to re-update summaries

