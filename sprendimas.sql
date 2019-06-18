5.
SELECT 
	`id_prekes`
	, `id_rinkos` 
	, `prekes_pardavimai`.`kiekis`
	, `prekes_pardavimai`.`vnt_kaina`
	, MIN(`prekes_pardavimai`.`data`) AS `nuo`
	, MAX(`prekes_pardavimai`.`data`) AS `iki`
FROM 
	`prekes_pardavimai` 
LEFT JOIN
	`prekes_gavimai` ON (
	
		`prekes_gavimai`.`id`=`prekes_pardavimai`.`id_prekes_gavimo`		
	)
LEFT JOIN 
	`prekes_tiekejai` ON (
	
		`prekes_tiekejai`.`barkodas`=`prekes_gavimai`.`barkodas`
	)
WHERE 
	1 
GROUP BY 
	`id_rinkos`, `id_prekes`, `prekes_pardavimai`.`vnt_kaina`
	;
	
ALTER TABLE `prekes_rinkos` ADD `id` INT UNSIGNED NOT NULL AUTO_INCREMENT FIRST, ADD PRIMARY KEY (`id`);
ALTER TABLE `prekes_rinkos` ADD FOREIGN KEY (`id_rinkos`) REFERENCES `prekes_pardavimai`(`id_rinkos`) ON DELETE CASCADE ON UPDATE CASCADE;

4.
SELECT 
	`id_prekes`
	, `preke`
	, SUM( `prekes_pardavimai`.`kiekis` ) AS `kiekis`
	, SUM( `prekes_pardavimai`.`vnt_kaina`*`prekes_pardavimai`.`kiekis` ) AS `parduota_uz`
FROM 
	`prekes_pardavimai` 
LEFT JOIN
	`prekes_gavimai` ON (
	
		`prekes_gavimai`.`id`=`prekes_pardavimai`.`id_prekes_gavimo`		
	)
LEFT JOIN 
	`prekes_tiekejai` ON (
	
		`prekes_tiekejai`.`barkodas`=`prekes_gavimai`.`barkodas`
	)
LEFT JOIN `prekes` ON (

		`prekes_tiekejai`.`id_prekes`=`prekes`.`id`
	)
WHERE 
	`prekes_pardavimai`.`data` BETWEEN '2013-06-01' AND  '2013-08-31'
GROUP BY 
	`id_prekes`
	
3.
SELECT 
	`id_prekes`
	, `preke`
	, `prekes_tiekejai`.`barkodas`
	, SUM( `prekes_gavimai`.`kiekis`) - SUM(`prekes_pardavimai`.`kiekis` ) AS `kiekis`
FROM 
	`prekes_pardavimai` 
LEFT JOIN
	`prekes_gavimai` ON (
	
		`prekes_gavimai`.`id`=`prekes_pardavimai`.`id_prekes_gavimo`		
	)
LEFT JOIN 
	`prekes_tiekejai` ON (
	
		`prekes_tiekejai`.`barkodas`=`prekes_gavimai`.`barkodas`
	)
LEFT JOIN `prekes` ON (

		`prekes_tiekejai`.`id_prekes`=`prekes`.`id`
	)
WHERE 
	1
GROUP BY 
	`id_prekes`, `prekes_tiekejai`.`barkodas`
HAVING 
	`kiekis`>0
	
2. a.
SELECT 
	YEAR(`prekes_pardavimai`.`data`)*100+MONTH(`prekes_pardavimai`.`data`) AS `menuo`
	, `id_prekes`
	, `preke`
	, `prekes`.`id_grupes`
	, `selektoriai`.`reiksme` AS `prekiu_grupe`
	, SUM( `prekes_gavimai`.`kiekis` )  AS `kiekis_gauta`
	, SUM( `prekes_gavimai`.`kiekis`*`prekes_gavimai`.`vnt_kaina`) AS `suma_gauta`
	, SUM( `prekes_pardavimai`.`kiekis` ) AS `kiekis_parduota`
	, SUM( `prekes_pardavimai`.`kiekis`*`prekes_gavimai`.`vnt_kaina`) AS `suma_parduota`
FROM 
	`prekes_pardavimai` 
LEFT JOIN
	`prekes_gavimai` ON (
	
		`prekes_gavimai`.`id`=`prekes_pardavimai`.`id_prekes_gavimo`		
	)
LEFT JOIN 
	`prekes_tiekejai` ON (
	
		`prekes_tiekejai`.`barkodas`=`prekes_gavimai`.`barkodas`
	)
LEFT JOIN `prekes` ON (

		`prekes_tiekejai`.`id_prekes`=`prekes`.`id`
	)
LEFT JOIN `selektoriai` ON (

			`prekes`.`id_grupes`=`selektoriai`.`id`
		AND
			`selektoriai`.`grupe`='prekiu_grupes'
	)
WHERE 
	1
GROUP BY 
	`id_prekes`, `id_rinkos`
HAVING 
	`kiekis`>0
	
2. a.
SELECT 
	YEAR(`prekes_pardavimai`.`data`)*100+MONTH(`prekes_pardavimai`.`data`) AS `menuo`
	, `id_prekes`
	, `preke`
	, `prekes`.`id_grupes`
	, `selektoriai`.`reiksme` AS `prekiu_grupe`
	, SUM( `prekes_gavimai`.`kiekis` )  AS `kiekis_gauta`
	, SUM( `prekes_gavimai`.`kiekis`*`prekes_gavimai`.`vnt_kaina`) AS `suma_gauta`
	, SUM( `prekes_pardavimai`.`kiekis` ) AS `kiekis_parduota`
	, SUM( `prekes_pardavimai`.`kiekis`*`prekes_gavimai`.`vnt_kaina`) AS `suma_parduota`
FROM 
	`prekes_pardavimai` 
LEFT JOIN
	`prekes_gavimai` ON (
	
		`prekes_gavimai`.`id`=`prekes_pardavimai`.`id_prekes_gavimo`		
	)
LEFT JOIN 
	`prekes_tiekejai` ON (
	
		`prekes_tiekejai`.`barkodas`=`prekes_gavimai`.`barkodas`
	)
LEFT JOIN `prekes` ON (

		`prekes_tiekejai`.`id_prekes`=`prekes`.`id`
	)
LEFT JOIN `selektoriai` ON (

			`prekes`.`id_grupes`=`selektoriai`.`id`
		AND
			`selektoriai`.`grupe`='prekiu_grupes'
	)
WHERE 
	1
GROUP BY 
	`prekes_pardavimai`.`id_prekes`
	
2. b.
SELECT 
	YEAR(`prekes_pardavimai`.`data`)*100+MONTH(`prekes_pardavimai`.`data`) AS `menuo`
	, `prekes`.`id_grupes`
	, `selektoriai`.`reiksme` AS `prekiu_grupe`
	, SUM( `prekes_gavimai`.`kiekis` )  AS `kiekis_gauta`
	, SUM( `prekes_gavimai`.`kiekis`*`prekes_gavimai`.`vnt_kaina`) AS `suma_gauta`
	, SUM( `prekes_pardavimai`.`kiekis` ) AS `kiekis_parduota`
	, SUM( `prekes_pardavimai`.`kiekis`*`prekes_gavimai`.`vnt_kaina`) AS `suma_parduota`
FROM 
	`prekes_pardavimai` 
LEFT JOIN
	`prekes_gavimai` ON (
	
		`prekes_gavimai`.`id`=`prekes_pardavimai`.`id_prekes_gavimo`		
	)
LEFT JOIN 
	`prekes_tiekejai` ON (
	
		`prekes_tiekejai`.`barkodas`=`prekes_gavimai`.`barkodas`
	)
LEFT JOIN `prekes` ON (

		`prekes_tiekejai`.`id_prekes`=`prekes`.`id`
	)
LEFT JOIN `selektoriai` ON (

			`prekes`.`id_grupes`=`selektoriai`.`id`
		AND
			`selektoriai`.`grupe`='prekiu_grupes'
	)
WHERE 
	1
GROUP BY 
	YEAR(`prekes_pardavimai`.`data`)*100+MONTH(`prekes_pardavimai`.`data`), `prekes`.`id_grupes`
	
2. a +b.
	( 
		SELECT 
			YEAR(`prekes_pardavimai`.`data`)*100+MONTH(`prekes_pardavimai`.`data`) AS `menuo`
			, `preke`
			, `prekes`.`id_grupes`
			, `selektoriai`.`reiksme` AS `prekiu_grupe`
			, SUM( `prekes_gavimai`.`kiekis` )  AS `kiekis_gauta`
			, SUM( `prekes_gavimai`.`kiekis`*`prekes_gavimai`.`vnt_kaina`) AS `suma_gauta`
			, SUM( `prekes_pardavimai`.`kiekis` ) AS `kiekis_parduota`
			, SUM( `prekes_pardavimai`.`kiekis`*`prekes_gavimai`.`vnt_kaina`) AS `suma_parduota`
		FROM 
			`prekes_pardavimai` 
		LEFT JOIN
			`prekes_gavimai` ON (
			
				`prekes_gavimai`.`id`=`prekes_pardavimai`.`id_prekes_gavimo`		
			)
		LEFT JOIN 
			`prekes_tiekejai` ON (
			
				`prekes_tiekejai`.`barkodas`=`prekes_gavimai`.`barkodas`
			)
		LEFT JOIN `prekes` ON (

				`prekes_tiekejai`.`id_prekes`=`prekes`.`id`
			)
		LEFT JOIN `selektoriai` ON (

					`prekes`.`id_grupes`=`selektoriai`.`id`
				AND
					`selektoriai`.`grupe`='prekiu_grupes'
			)
		WHERE 
			1
		GROUP BY 
			YEAR(`prekes_pardavimai`.`data`)*100+MONTH(`prekes_pardavimai`.`data`), `prekes_pardavimai`.`id_prekes`
		
	) UNION (

		SELECT 
			YEAR(`prekes_pardavimai`.`data`)*100+MONTH(`prekes_pardavimai`.`data`) AS `menuo`
			, 'zz_viso' AS `preke`
			, `prekes`.`id_grupes`
			, `selektoriai`.`reiksme` AS `prekiu_grupe`
			, SUM( `prekes_gavimai`.`kiekis` )  AS `kiekis_gauta`
			, SUM( `prekes_gavimai`.`kiekis`*`prekes_gavimai`.`vnt_kaina`) AS `suma_gauta`
			, SUM( `prekes_pardavimai`.`kiekis` ) AS `kiekis_parduota`
			, SUM( `prekes_pardavimai`.`kiekis`*`prekes_gavimai`.`vnt_kaina`) AS `suma_parduota`
		FROM 
			`prekes_pardavimai` 
		LEFT JOIN
			`prekes_gavimai` ON (
			
				`prekes_gavimai`.`id`=`prekes_pardavimai`.`id_prekes_gavimo`		
			)
		LEFT JOIN 
			`prekes_tiekejai` ON (
			
				`prekes_tiekejai`.`barkodas`=`prekes_gavimai`.`barkodas`
			)
		LEFT JOIN `prekes` ON (

				`prekes_tiekejai`.`id_prekes`=`prekes`.`id`
			)
		LEFT JOIN `selektoriai` ON (

					`prekes`.`id_grupes`=`selektoriai`.`id`
				AND
					`selektoriai`.`grupe`='prekiu_grupes'
			)
		WHERE 
			1
		GROUP BY 
			YEAR(`prekes_pardavimai`.`data`)*100+MONTH(`prekes_pardavimai`.`data`), `prekes`.`id_grupes`
	)
	ORDER BY
		`menuo`, `id_grupes`, `preke`

1.