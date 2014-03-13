Extension { #name : #DBXTable }

{ #category : #'*GT-InspectorExtensions-DBXDatabaseModel' }
DBXTable >> columnsDo: aBlock [
	columns do: aBlock.
]

{ #category : #'*GT-InspectorExtensions-DBXDatabaseModel' }
DBXTable >> foreignKeyForColumn: aColumn [
	^foreignKeys detect: [ :fk | fk isForColumn: aColumn ]
]

{ #category : #'*GT-InspectorExtensions-DBXDatabaseModel' }
DBXTable >> foreignKeyNamed: fkName [
	^foreignKeys detect: [ :fk | fk name = fkName ] 
		ifNone: [ 
			| fk |
			fk := DBXForeignKey named: fkName. 
			foreignKeys add: fk.
			fk "return created foreign key"
			]
]

{ #category : #'*GT-InspectorExtensions-DBXDatabaseModel' }
DBXTable >> generateCreateTable [
	| columnsSql template |
	template := 'CREATE TABLE {1} ( {2} )'.
	columnsSql := ', ' join: ((columns asOrderedCollection , foreignKeys asOrderedCollection) collect: #generateSQLForCreateTable ).
	primaryKeyColumns ifNotEmpty: [ columnsSql := columnsSql ,  ', ' , self primaryKeySQLForCreateTable ].
	^template format: {self name . columnsSql }
]

{ #category : #'*GT-InspectorExtensions-DBXDatabaseModel' }
DBXTable >> generateDropTable [
	^  ' DROP TABLE {1} ' format: { self name }.
]

{ #category : #'*GT-InspectorExtensions-DBXDatabaseModel' }
DBXTable >> gtInspectorColumnsIn: composite inContext: anInspector [
	<gtInspectorPresentationOrder: 40>

	composite table
		title: 'Columns';
		display: [ self columns ];
		column: 'Name' evaluated: [ :each | each name ];
		column: 'Type' evaluated: [ :each | each type typeName ]
]

{ #category : #'*GT-InspectorExtensions-DBXDatabaseModel' }
DBXTable >> initialize [ 
	columns := Set new.
	foreignKeys := Set new.
	primaryKeyColumns := Set new.
	uniqueConstraints := Set new
]

{ #category : #'*GT-InspectorExtensions-DBXDatabaseModel' }
DBXTable >> isForeignKey: aColumn [ 
	^foreignKeys anySatisfy: [ :fk | fk isForColumn: aColumn ].
]

{ #category : #'*GT-InspectorExtensions-DBXDatabaseModel' }
DBXTable >> isPrimaryKeyComponent: aColumn [
	^primaryKeyColumns anySatisfy: [ :c | c columnName = aColumn name ].
]

{ #category : #'*GT-InspectorExtensions-DBXDatabaseModel' }
DBXTable >> name [
	^name
]

{ #category : #'*GT-InspectorExtensions-DBXDatabaseModel' }
DBXTable >> name:aName [
	name := aName .
]

{ #category : #'*GT-InspectorExtensions-DBXDatabaseModel' }
DBXTable >> primaryKeySQLForCreateTable [
	| template |
	template := 'CONSTRAINT {1} PRIMARY KEY ({2})'.
	columns := ',' join: (primaryKeyColumns collect: #columnName).
	^template format:{ 'pk_', self name . columns }
]
