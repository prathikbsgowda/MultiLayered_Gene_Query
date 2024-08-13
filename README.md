# MultiLayered_Gene_Query

This repository contains an SQL query that analyzes gene interactions related to the `PAK1` gene. The query is structured using multiple nested subqueries to identify and calculate interaction frequencies, shared scores, and other key metrics for the gene and its interactors.

## Query Overview

The SQL query is broken down into several components:

1. **Kinase Interaction (`kin`)**: 
   - Identifies distinct condition IDs, site IDs, and gene IDs where the gene `PAK1` is involved.

2. **Binary Interactions (`inter_binary`)**:
   - Identifies genes that interact with `PAK1` based on binary interaction data.

3. **Interactor Analysis (`inter`)**:
   - Identifies distinct condition IDs, site IDs, and gene IDs for genes that interact with those identified in `inter_binary`.

4. **Kinase Interaction Frequency (`count_kin`)**:
   - Counts the frequency of distinct condition IDs associated with the `PAK1` gene, grouped by site ID.

5. **Interactor Frequency (`count_inter`)**:
   - Counts the frequency of distinct condition IDs associated with genes that interact with those identified in `inter_binary`, grouped by site ID and gene ID.

6. **Shared Frequency (`shared_freq`)**:
   - Calculates the shared frequency of condition IDs between `PAK1` and its interactors.

7. **Final Selection**:
   - Selects key metrics such as the minimum frequency and shared score for each site ID, combining data from the `kin`, `count_kin`, and `count_inter` tables.

## Output

The final output of the query includes the following columns:

- `kin`: Gene ID for `PAK1`.
- `kin_sit`: Site ID for the `PAK1` interaction.
- `kin_freq`: Frequency of `PAK1` interaction at the site.
- `shared_freqn`: Shared frequency between `PAK1` and the binary interactor.
- `Binary_interactor`: Gene ID of the binary interactor.
- `site_id`: Site ID for the interaction.
- `interact_freq`: Frequency of interaction for the binary interactor at the site.
- `min_freq`: Minimum frequency between `PAK1` and the binary interactor.
- `shared_score`: Shared score calculated as the ratio of the shared frequency to the minimum frequency.

## Usage

To use this query, simply run it against your database, ensuring that the relevant tables (`co_bi_inter_groupidconditions`, `co_bi_inter_conditiongroups`, `co_bi_inter_genebinayinter`) are available and contain the appropriate data.

## License

This project is open-source and licensed under the MIT License. Feel free to use and modify the query as needed.

