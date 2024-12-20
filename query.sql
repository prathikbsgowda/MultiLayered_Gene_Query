
WITH kin AS (SELECT DISTINCT  co_bi_inter_groupidconditions.condition_id_id,site_id AS kin_sit,gene_id AS kin 
						FROM co_bi_inter_conditiongroups JOIN co_bi_inter_groupidconditions
						 ON co_bi_inter_conditiongroups.condition_group_id=co_bi_inter_groupidconditions.groupid_id 
						WHERE co_bi_inter_conditiongroups.gene_id = 'TTN'
				),

inter_binary AS (
    SELECT DISTINCT a.GENE_ID
    FROM co_bi_inter_genebinayinter a
    JOIN co_bi_inter_genebinayinter b ON a.interactor_id = b.interactor_id 
    WHERE b.gene_id='PAK1'
						),
	
inter AS (
			SELECT DISTINCT  co_bi_inter_groupidconditions.condition_id_id,site_id,gene_id FROM co_bi_inter_conditiongroups 
 			JOIN co_bi_inter_groupidconditions ON co_bi_inter_conditiongroups.condition_group_id=co_bi_inter_groupidconditions.groupid_id 
			WHERE co_bi_inter_conditiongroups.gene_id IN (SELECT * FROM inter_binary)
			),
	
count_kin AS (
					SELECT site_id,COUNT(DISTINCT co_bi_inter_groupidconditions.condition_id_id) AS kin_freq,gene_id AS kin 
					FROM co_bi_inter_conditiongroups JOIN co_bi_inter_groupidconditions
					ON co_bi_inter_conditiongroups.condition_group_id=co_bi_inter_groupidconditions.groupid_id 
					WHERE co_bi_inter_conditiongroups.gene_id = ' ' GROUP BY site_id),
	
	
count_inter AS (
					SELECT   count(DISTINCT co_bi_inter_groupidconditions.condition_id_id)AS interact_freq,site_id,gene_id 
					FROM co_bi_inter_conditiongroups JOIN co_bi_inter_groupidconditions 
					ON co_bi_inter_conditiongroups.condition_group_id=co_bi_inter_groupidconditions.groupid_id 
					WHERE co_bi_inter_conditiongroups.gene_id IN (SELECT * FROM inter_binary) GROUP BY site_id,gene_id
					),
	

shared_freq AS ( 
					SELECT kin,kin_sit,count(DISTINCT kin.condition_id_id )AS shared_freqn,gene_id AS Binary_interactor,site_id
					 FROM kin INNER JOIN inter ON kin.condition_id_id = inter.condition_id_id 
					 GROUP BY kin_sit,kin,site_id,gene_id
					 )
	
SELECT shared_freq.kin,kin_sit,kin_freq,shared_freqn,Binary_interactor,shared_freq.site_id,interact_freq,
			LEAST ( kin_freq , interact_freq )AS min_freq ,
			(CAST(shared_freqn AS DECIMAL(10, 2)) / CAST(LEAST( kin_freq , interact_freq ) AS DECIMAL(10, 2))) AS shared_score
				FROM shared_freq JOIN count_kin ON count_kin.site_id = shared_freq.kin_sit 
				JOIN count_inter ON shared_freq.Binary_interactor = count_inter.gene_id 
				AND shared_freq.site_id = count_inter.site_id
 
