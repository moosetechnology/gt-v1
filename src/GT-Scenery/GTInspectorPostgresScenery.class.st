Class {
	#name : #GTInspectorPostgresScenery,
	#superclass : #GTScenery,
	#category : #'GT-Scenery'
}

{ #category : #'as yet unclassified' }
GTInspectorPostgresScenery class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 6.0; 
		parent: #GTScenery;
		label: 'Inspector - Postgres';
		action:[self new setUp]
]

{ #category : #setUp }
GTInspectorPostgresScenery >> setUp [
	self cleanWindows.
	(GTPlayground openContents: '| conn |
conn := PGConnection new.
conn connectionArgs:
		(PGConnectionArgs
			hostname: ''localhost''
			portno: 5432
			databaseName: ''girba''
			userName: ''girba''
			password: '''').
conn startup.
conn').
	GTSnippets reset.
	GTSnippets snippetAt: #'PGConnection-SQL' put: 'select * from city
select 
		city.countrycode, 
		city.name as cityname, 
		city.population, 
		country.lifeexpectancy as life, 
		country.continent 
			from city 
			left join country
				on city.countrycode=country.code'.
	GTSnippets snippetAt: #PGResultSet asClass put: '| builder models |
models := (self dataRows
		sortDescending: [ :x | x atName: #population ])
		first: 100.
builder := GET2DiagramBuilder new.
builder horizontalBarDiagram
	models: models;
	modelLabels: [ :row | row atName: #cityname ];
	x: [ :row | row atName: #population ]";
	color: ((RTNIdentityNormalizer 
		withCommand: [ :row | row atName: #continent ]))".
builder view canvas when: TRResizeCanvasEvent do: [ 
		builder view canvas camera translateTo: 0@300. ].
builder'
]
