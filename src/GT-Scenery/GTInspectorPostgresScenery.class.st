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
	GTSnippets snippetAt: #PGResultSet asClass put: 'models := (self dataRows
		sortDescending: [ :x | x atName: #population ])
		first: 30.
builder := RTGrapher new.
data := RTData new.
data points: models.
data barShape
	"color: ((RTNIdentityNormalizer 
		withCommand: [ :row | row atName: #continent ]))".
data 
	barChartWithBarTitle: [ :row | row atName: #cityname ];
	y: [ :row | row atName: #population ].
builder add: data.
builder axisY.
builder axisX noTick; noLabel.
builder'
]
