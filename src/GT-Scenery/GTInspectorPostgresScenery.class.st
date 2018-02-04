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
	(GTPlayground openContents: 'P3Client new url: ''psql://girba:@localhost:5432/girba''').
	GTSnippets reset.
	GTSnippets snippetAt: #'P3Client-SQL' put: 'select 
		city.name as cityname, 
		city.population, 
		country.continent 
			from city 
			left join country
				on city.countrycode=country.code'.
	GTSnippets snippetAt: #P3Result asClass put: 'models := (self data
		sortDescending: [ :x | x second ])
		first: 20.
builder := RTGrapher new.
rtData := RTData new.
rtData points: models.
"rtData barShape color: (RTNIdentityNormalizer withCommand: [ :row | row third ])."
rtData 
	barChartWithBarTitle: [ :row | row first ];
	y: [ :row | row second ].
builder add: rtData.
builder axisY.
builder axisX noTick; noLabel.
builder extent: 400@300.
builder'
]
