"
A GTSpotterEventRecorderTest is a test class for testing the behavior of GTSpotterEventRecorder
"
Class {
	#name : #GTSpotterEventRecorderTest,
	#superclass : #TestCase,
	#instVars : [
		'recorder',
		'checkedEvents'
	],
	#category : #'GT-Spotter-EventRecorder-Tests'
}

{ #category : #accessing }
GTSpotterEventRecorderTest class >> instancesForAllEvents [
	"We instantiate all events and set all instance variables."
	^ GTSpotterRecorderEvent allSubclasses collect: [ :eachEventClass | | instance |
		instance := eachEventClass new.
		1 to: eachEventClass instSize do: [ :index |
			(instance instVarAt: index) ifNil: [ | variableName |
				variableName := eachEventClass instVarNameForIndex: index.
				(instance respondsTo: variableName) ifTrue: [ instance perform: variableName ] ].
			(instance instVarAt: index) ifNil: [ 
				instance instVarAt: index put: #value ] ].
		instance
	 ]
]

{ #category : #accessing }
GTSpotterEventRecorderTest class >> serializeAnnouncementWithAllEvents [
	"self serializeAnnouncementWithAllEvents"
	| recorder |
	recorder := GTSpotterEventRecorder new.
	recorder stopDelivering. 
	^ recorder serializedAnnouncementFrom: self instancesForAllEvents.
	
]

{ #category : #accessing }
GTSpotterEventRecorderTest class >> storeSerializedAnnouncementIntoMethod: aSymbol [
	"self storeSerializedAnnouncementIntoMethod: #version2"
	| methodSource |
	methodSource := (String streamContents: [ :aStream |
		aStream 
			nextPutAll: aSymbol asString; cr; 
			tab; 
			nextPutAll: '"Automatically created by class method #storeSerializedAnnouncementIntoMethod: ';
			print: aSymbol;
			nextPut: $.;
			cr; tab;
			nextPutAll: 'It is a serialized event recorder announcement GTSpotterRecorderDataAnnouncement.';
			cr; tab;
			nextPutAll: 'It contatins all instances of the recorder events."';
			cr; tab;
			nextPutAll: '<spotterEventRecorderSerializedData>';
			cr; tab;
			nextPutAll: '^ '.
		self serializeAnnouncementWithAllEvents storeOn: aStream. ]).
	self compile: methodSource classified: 'serialized data'.
]

{ #category : #accessing }
GTSpotterEventRecorderTest >> allPragmaVersions [
	^ Pragma allNamed: #spotterEventRecorderSerializedData in: self class.
]

{ #category : #asserting }
GTSpotterEventRecorderTest >> assertAnnouncement: announcement [
	self assert: announcement notNil.
	self assert: (announcement isKindOf: GTSpotterRecorderDataAnnouncement).
	announcement materializedData do: [ :eachEvent |
		"Check that all instance variables have some value."
		1 to: eachEvent class instSize do: [ :index |
			self 
				assert: (eachEvent instVarAt: index) notNil 
				description: [ String streamContents: [ :aStream |
						aStream 
							nextPutAll: 'Instance variable called ';
							print: (eachEvent class instVarNameForIndex: index);
							nextPutAll: ' of instance ';
							nextPutAll: eachEvent className;
							nextPutAll: ' is nil.' ] ]
		]
	]
]

{ #category : #asserting }
GTSpotterEventRecorderTest >> assertVersion: aMethodName [
	| announcement |
	announcement := recorder materialize: (self perform: aMethodName).
	self assertAnnouncement: announcement.
	checkedEvents addAll: (announcement materializedData collect: #class).
]

{ #category : #accessing }
GTSpotterEventRecorderTest >> materializePragmaVersion: aPragma [
	^ recorder materialize: (self perform: aPragma selector).
]

{ #category : #accessing }
GTSpotterEventRecorderTest >> recordedData [
	^ GTSpotterRecorderEvent allSubclasses collect: #new
]

{ #category : #running }
GTSpotterEventRecorderTest >> setUp [
	super setUp.
	recorder := GTSpotterEventRecorder new.
	recorder stopDelivering.
]

{ #category : #tests }
GTSpotterEventRecorderTest >> testDateAndTime [
	self versionsDo: [ :announcement :version |
		announcement materializedData do: [ :eachEvent | | dateAndTime |
			dateAndTime := eachEvent dateAndTime.
			self assert: dateAndTime class equals: DateAndTime ] ]
]

{ #category : #tests }
GTSpotterEventRecorderTest >> testMaterializeVersions [
	| versions notMaterializedEvents |
	checkedEvents := Set new.
	versions := self allPragmaVersions.
	self assert: versions notEmpty.
	versions do: [ :eachPragma |
		self assertVersion: eachPragma selector ].
	self assert: checkedEvents notEmpty.
	notMaterializedEvents := GTSpotterRecorderEvent allSubclasses 
		removeAll: checkedEvents; 
		yourself.
	self 
		assert: notMaterializedEvents isEmpty
		description: [ 
			'Some events are not tested for backward compatibility.', String cr,
			'You should create new version using method #storeSerializedAnnouncementIntoMethod:.', String cr,
			'Do not override the existing serialized versions!'
		]
]

{ #category : #tests }
GTSpotterEventRecorderTest >> testPostponeSomeDataOnAct [
	| maybeDeliveredData toBeDeliveredData postponedData |
	self assert: recorder postponedData isNil.
	maybeDeliveredData := recorder newCollectionWithPostponedData.
	self assert: maybeDeliveredData size equals: 0.
	maybeDeliveredData 
		add: GTSpotterRecorderOpenEvent new;
		add: GTSpotterRecorderShowPreviewEvent new;
		add: GTSpotterRecorderExitAnnouncementEvent new;
		add: GTSpotterRecorderOpenEvent new;
		add: GTSpotterRecorderShowPreviewEvent new;
		add: GTSpotterRecorderActOnEvent new;
		add: GTSpotterRecorderOpenEvent new;
		add: GTSpotterRecorderShowPreviewEvent new.
	toBeDeliveredData := recorder postponeSomeData: maybeDeliveredData.
	postponedData := recorder postponedData.
	self assert: toBeDeliveredData size equals: 6.
	self assert: postponedData size equals: 2.
	1 to: 6 do: [ :index |
		self assert: (maybeDeliveredData at: index) == (toBeDeliveredData at: index) ].
	7 to: 8 do: [ :index |
		self assert: (maybeDeliveredData at: index) == (postponedData at: index - 6) ].
	"second delivery"
	maybeDeliveredData := recorder newCollectionWithPostponedData.
	self assert: recorder postponedData isNil.
	self assert: maybeDeliveredData size equals: 2.
	1 to: 2 do: [ :index |
		self assert: (maybeDeliveredData at: index) == (postponedData at: index) ].
	self assert: recorder postponedData isNil.
	maybeDeliveredData
		add: GTSpotterRecorderActOnEvent new.
	toBeDeliveredData := recorder postponeSomeData: maybeDeliveredData.
	postponedData := recorder postponedData.
	self assert: toBeDeliveredData size equals: 3.
	self assert: postponedData isNil.
	1 to: 3 do: [ :index |
		self assert: (maybeDeliveredData at: index) == (toBeDeliveredData at: index) ].

]

{ #category : #tests }
GTSpotterEventRecorderTest >> testPostponeSomeDataOnExit [
	| maybeDeliveredData toBeDeliveredData postponedData |
	self assert: recorder postponedData isNil.
	maybeDeliveredData := recorder newCollectionWithPostponedData.
	self assert: maybeDeliveredData size equals: 0.
	maybeDeliveredData 
		add: GTSpotterRecorderOpenEvent new;
		add: GTSpotterRecorderShowPreviewEvent new;
		add: GTSpotterRecorderExitAnnouncementEvent new;
		add: GTSpotterRecorderOpenEvent new;
		add: GTSpotterRecorderShowPreviewEvent new;
		add: GTSpotterRecorderExitAnnouncementEvent new;
		add: GTSpotterRecorderOpenEvent new;
		add: GTSpotterRecorderShowPreviewEvent new.
	toBeDeliveredData := recorder postponeSomeData: maybeDeliveredData.
	postponedData := recorder postponedData.
	self assert: toBeDeliveredData size equals: 6.
	self assert: postponedData size equals: 2.
	1 to: 6 do: [ :index |
		self assert: (maybeDeliveredData at: index) == (toBeDeliveredData at: index) ].
	7 to: 8 do: [ :index |
		self assert: (maybeDeliveredData at: index) == (postponedData at: index - 6) ].
	"second delivery"
	maybeDeliveredData := recorder newCollectionWithPostponedData.
	self assert: recorder postponedData isNil.
	self assert: maybeDeliveredData size equals: 2.
	1 to: 2 do: [ :index |
		self assert: (maybeDeliveredData at: index) == (postponedData at: index) ].
	self assert: recorder postponedData isNil.
	maybeDeliveredData
		add: GTSpotterRecorderExitAnnouncementEvent new.
	toBeDeliveredData := recorder postponeSomeData: maybeDeliveredData.
	postponedData := recorder postponedData.
	self assert: toBeDeliveredData size equals: 3.
	self assert: postponedData isNil.
	1 to: 3 do: [ :index |
		self assert: (maybeDeliveredData at: index) == (toBeDeliveredData at: index) ].

]

{ #category : #tests }
GTSpotterEventRecorderTest >> testPrimitivePrepareDeliveryData [
	| maybeDeliveredData  postponedData bytes announcement events |
	self assert: recorder postponedData isNil.
	maybeDeliveredData := OrderedCollection new.
	maybeDeliveredData 
		add: GTSpotterRecorderOpenEvent new;
		add: GTSpotterRecorderShowPreviewEvent new;
		add: GTSpotterRecorderExitAnnouncementEvent new;
		add: GTSpotterRecorderOpenEvent new;
		add: GTSpotterRecorderShowPreviewEvent new;
		add: GTSpotterRecorderExitAnnouncementEvent new;
		add: GTSpotterRecorderOpenEvent new;
		add: GTSpotterRecorderShowPreviewEvent new.
	maybeDeliveredData do: [ :each | recorder recordedData nextPut: each ].
	recorder primitivePrepareDeliveryData.
	postponedData := recorder postponedData.
	self assert: postponedData size equals: 2.
	7 to: 8 do: [ :index |
		self assert: (maybeDeliveredData at: index) == (postponedData at: index - 6) ].
	"second delivery"
	recorder recordedData nextPut: GTSpotterRecorderExitAnnouncementEvent new.
	recorder primitivePrepareDeliveryData.
	postponedData := recorder postponedData.
	self assert: postponedData isNil.
	self assert: recorder deliveryQueue size equals: 2.
	"first delivered data"
	bytes := recorder deliveryQueue nextOrNil.
	self assert: bytes notNil.
	announcement := recorder materialize: bytes.
	events := announcement materializedData.
	self assert: events size equals: 6.
	events withIndexDo: [ :eachEvent :index |
		self assert: (maybeDeliveredData at: index) class = eachEvent class ].
	"second delivered data"
	bytes := recorder deliveryQueue nextOrNil.
	self assert: bytes notNil.
	announcement := recorder materialize: bytes.
	events := announcement materializedData.
	self assert: events size equals: 3.
	self assert: (maybeDeliveredData at: 7) class = events first class.
	self assert: (maybeDeliveredData at: 8) class = events second class.
	self assert: events third class = GTSpotterRecorderExitAnnouncementEvent.
]

{ #category : #tests }
GTSpotterEventRecorderTest >> testSerializedAnnouncementFrom [
	| byteArray announcement |
	byteArray := recorder serializedAnnouncementFrom: self recordedData.
	announcement := recorder materializedAnnouncementFrom: byteArray.
	self assert: announcement class equals: GTSpotterRecorderDataAnnouncement.
	self assert: announcement materializedData isCollection.
	self assert: announcement materializedData size equals: self recordedData size.
]

{ #category : #'serialized data' }
GTSpotterEventRecorderTest >> version1 [
	"Automatically created by class method #storeSerializedAnnouncementIntoMethod: #version1.
	It is a serialized event recorder announcement GTSpotterRecorderDataAnnouncement.
	It contatins all instances of the recorder events."
	<spotterEventRecorderSerializedData>
	^ #[31 139 8 0 0 0 0 0 0 0 115 11 117 245 97 56 196 200 192 192 192 207 0 1 236 34 110 62 238 57 249 73 137 57 206 57 137 197 197 206 57 165 197 37 169 69 64 9 86 14 55 31 143 212 196 148 212 34 33 207 148 212 188 146 204 146 74 151 204 228 146 204 252 188 196 162 74 46 167 202 146 212 224 202 220 164 252 28 65 255 34 160 154 212 20 231 252 156 156 84 176 60 127 104 94 74 106 90 102 94 106 138 127 82 22 80 72 206 205 39 32 191 56 179 36 179 44 213 34 56 55 49 39 199 51 175 36 53 61 181 8 97 23 19 3 163 24 208 182 252 252 236 128 162 204 92 176 74 132 36 35 51 127 81 106 114 62 200 150 176 212 162 98 160 5 120 212 178 2 189 227 150 89 1 179 26 73 134 145 69 178 160 40 213 55 17 200 205 76 204 201 172 74 4 57 213 17 236 224 98 193 196 148 148 76 176 215 114 32 250 138 165 10 242 139 75 176 43 230 207 69 21 150 117 243 65 4 12 34 20 144 172 102 2 17 146 110 62 193 153 185 5 57 169 216 148 48 177 64 163 131 129 135 155 151 19 164 156 131 29 38 194 5 196 146 48 54 174 216 98 227 4 197 136 99 81 81 34 52 110 74 138 50 243 210 145 162 137 219 5 232 106 199 188 148 144 204 220 84 69 247 144 224 130 252 18 160 206 32 104 192 2 37 19 29 243 242 242 75 243 146 83 115 129 145 205 133 240 145 60 34 246 12 205 176 71 31 227 188 62 220 81 194 196 196 17 144 145 88 148 111 162 103 160 98 106 145 98 98 148 146 104 166 155 108 105 105 172 107 146 152 98 168 107 97 102 100 162 107 154 150 98 102 100 97 110 105 108 102 104 64 68 106 97 228 192 99 29 11 131 106 157 148 252 233 59 27 24 246 6 255 191 122 1 28 108 64 17 163 61 42 55 24 214 231 67 69 112 235 231 96 230 204 204 77 76 79 245 72 44 206 96 73 1 6 139 112 113 106 49 40 209 57 23 165 130 163 27 20 128 60 201 249 185 5 165 64 13 161 161 158 46 156 37 64 145 226 146 196 220 2 145 212 50 96 216 5 161 38 86 158 28 96 192 23 151 132 22 0 13 75 229 1 155 13 149 65 10 89 99 35 28 33 203 186 213 79 71 216 205 7 20 143 152 41 26 232 219 38 249 110 14 104 218 152 58 37 55 252 178 129 200 241 221 59 185 122 30 205 8 19 17 16 112 172 113 99 149 255 160 58 77 180 204 207 246 113 192 135 218 109 113 17 38 190 89 147 248 158 29 255 172 252 147 211 103 247 217 115 165 115 85 159 111 137 46 174 255 121 255 78 245 228 236 249 87 101 222 134 59 94 222 210 117 77 58 120 217 91 25 161 107 46 71 148 60 56 186 91 156 152 194 217 106 111 149 245 49 84 30 200 191 110 187 64 232 244 59 198 60 207 51 26 143 238 126 122 190 142 101 251 107 115 201 149 102 59 146 14 108 150 80 20 184 173 157 126 165 185 216 231 96 182 201 254 149 43 67 111 91 166 49 121 223 105 180 189 238 222 114 101 101 11 247 131 206 245 139 194 34 2 238 73 252 174 59 179 81 126 114 231 198 130 197 135 22 30 85 210 143 111 228 126 154 192 180 122 117 65 78 141 105 129 109 138 230 20 49 102 190 248 9 191 142 116 60 152 175 113 235 85 221 158 196 64 215 121 237 143 47 120 228 207 141 224 154 49 225 241 195 174 255 239 191 116 189 85 233 244 220 100 240 100 151 196 94 177 220 227 71 235 28 18 100 130 116 190 158 94 40 185 185 216 88 208 206 214 116 134 230 234 229 247 254 215 171 175 142 250 60 187 125 121 222 129 37 191 172 94 170 159 78 210 58 27 126 41 75 185 138 49 110 237 226 172 25 109 124 33 191 94 93 9 18 140 53 184 215 187 112 225 173 105 147 15 92 74 189 119 66 96 181 224 135 169 62 107 182 206 75 234 219 192 126 92 198 74 66 47 57 41 117 141 151 242 153 168 247 219 110 62 253 80 117 215 205 229 64 217 172 230 140 217 89 251 59 170 110 4 127 228 125 158 168 61 119 77 29 27 219 105 163 13 183 68 167 253 158 178 105 194 182 73 10 211 131 34 148 25 102 77 44 16 23 200 223 154 235 179 49 227 251 93 157 229 10 165 151 164 108 27 57 221 247 206 121 30 39 57 249 221 212 123 142 42 45 91 93 210 202 211 247 244 21 110 251 115 123 239 185 201 181 220 95 37 59 107 5 132 126 58 114 94 46 78 75 40 20 50 239 214 152 59 53 236 196 206 95 182 161 207 183 173 235 249 236 24 146 41 214 117 208 101 89 222 70 139 69 179 61 239 157 241 245 123 170 182 188 120 178 241 206 147 55 239 164 44 53 113 122 101 239 20 96 107 245 96 13 171 147 129 158 209 244 115 79 203 138 180 205 51 123 242 210 215 93 221 31 195 151 197 100 184 224 186 188 78 105 103 202 178 19 127 86 236 254 95 22 249 56 159 251 172 181 90 217 147 38 185 204 117 111 195 124 139 31 30 254 116 124 234 219 171 123 217 223 191 223 91 189 35 121 150 247 250 119 251 118 254 191 102 34 30 159 125 93 254 216 105 241 215 253 102 114 246 183 107 254 125 57 121 109 185 125 101 228 132 199 19 128 165 20 206 18 151 149 145 43 5 94 140 16 46 37 217 64 185 15 84 208 113 136 114 8 114 10 240 10 115 9 241 240 137 241 139 139 176 75 0 0 84 138 255 137 183 6 0 0]
]

{ #category : #'serialized data' }
GTSpotterEventRecorderTest >> version2 [
	"Automatically created by class method #storeSerializedAnnouncementIntoMethod: #version2.
	It is a serialized event recorder announcement GTSpotterRecorderDataAnnouncement.
	It contatins all instances of the recorder events."
	<spotterEventRecorderSerializedData>
	^ #[31 139 8 0 0 0 0 0 0 0 115 11 117 245 97 56 196 200 192 192 192 207 0 1 236 34 110 62 238 57 249 73 137 57 206 57 137 197 197 206 57 165 197 37 169 69 64 9 86 14 55 31 143 212 196 148 212 34 33 207 148 212 188 146 204 146 74 151 204 228 146 204 252 188 196 162 74 46 167 202 146 212 224 202 220 164 252 28 65 255 34 160 154 212 20 231 252 156 156 84 176 60 127 104 94 74 106 90 102 94 106 138 127 82 22 80 72 206 205 39 32 191 56 179 36 179 44 213 34 56 55 49 39 199 51 175 36 53 61 181 8 97 23 51 3 35 147 24 208 186 252 252 236 128 162 204 92 176 82 132 44 35 51 127 81 106 114 62 200 154 176 212 162 98 160 13 120 212 178 2 253 227 150 89 1 179 27 73 134 145 69 178 160 40 213 55 17 200 205 76 204 201 172 74 4 185 213 17 236 226 98 193 196 148 148 76 176 223 114 32 250 138 165 10 242 139 75 176 43 230 207 69 21 150 117 243 65 132 12 34 24 144 172 102 2 17 146 110 62 193 153 185 5 57 169 216 148 48 177 64 227 131 129 151 135 143 11 164 156 147 3 38 194 13 196 146 80 54 23 174 232 98 227 4 69 137 99 81 81 34 52 114 74 138 50 243 210 145 226 137 219 5 232 106 199 188 148 144 204 220 84 69 247 144 224 130 252 18 160 206 32 104 192 2 37 19 29 243 242 242 75 243 146 83 115 129 177 205 133 240 145 60 34 250 12 205 176 199 31 227 188 41 184 163 132 137 73 197 212 34 197 196 40 37 209 76 55 217 210 210 88 215 36 49 197 80 215 194 204 200 68 215 52 45 197 204 200 194 220 210 216 204 208 128 35 32 35 177 40 223 68 207 128 112 114 97 226 192 147 90 128 33 169 90 167 108 154 114 107 2 195 150 245 255 175 94 0 7 27 80 68 50 55 170 131 97 109 25 84 4 183 126 14 102 206 204 220 196 244 84 143 196 226 12 150 20 96 176 8 23 167 22 131 18 157 115 81 42 56 186 65 1 200 147 156 159 91 80 10 212 16 26 234 233 194 89 2 20 41 46 73 204 45 16 73 45 3 134 93 16 106 98 229 201 1 6 124 113 73 104 1 208 176 84 30 176 217 80 25 164 144 53 54 194 17 178 172 91 253 116 132 221 124 64 241 136 153 162 129 190 125 38 223 13 75 40 83 67 125 131 133 13 37 238 77 91 231 16 169 241 212 155 177 112 77 77 71 124 71 87 211 188 35 151 90 173 74 79 5 124 152 87 22 159 97 50 123 205 201 109 1 252 114 50 252 247 246 252 146 183 169 184 32 121 92 114 191 127 220 156 143 139 246 31 94 108 126 54 47 58 106 123 78 164 241 229 187 239 38 171 159 159 188 39 255 147 219 125 175 212 41 250 138 174 129 73 94 91 75 249 94 206 12 61 244 169 67 133 83 72 201 211 235 16 155 158 245 21 61 219 205 108 39 24 236 38 152 53 220 186 177 110 205 131 166 94 73 215 61 66 123 67 55 42 134 27 126 238 57 178 57 166 232 128 135 145 211 129 183 253 185 129 204 219 12 89 149 103 239 87 95 40 92 149 54 151 51 231 177 145 206 83 31 23 143 89 183 54 48 239 121 120 117 97 203 33 229 75 125 27 127 191 150 153 173 183 245 162 244 171 142 66 13 131 227 207 244 10 20 101 111 21 132 238 148 147 125 127 117 239 236 42 167 137 129 221 135 101 85 236 13 149 126 40 22 61 219 245 230 92 196 145 137 137 9 229 185 75 172 252 122 34 125 110 176 79 78 126 182 255 67 203 188 76 151 101 130 109 106 175 55 124 150 184 106 108 153 19 197 194 183 168 69 121 107 141 198 222 168 248 43 11 203 203 175 78 148 251 185 59 246 183 253 139 233 235 126 92 121 149 118 46 105 219 159 91 43 88 181 79 166 204 249 254 38 69 240 162 172 65 80 234 204 35 97 151 186 120 226 103 169 61 237 42 147 88 191 99 201 178 39 110 210 220 217 103 63 47 233 143 232 106 208 76 141 89 235 194 157 206 43 189 225 220 194 158 196 235 169 95 214 120 188 79 205 202 73 18 86 227 11 57 51 237 207 150 34 215 109 183 215 44 125 213 193 49 35 251 105 163 113 170 101 185 11 111 142 199 254 103 51 206 108 97 91 39 214 251 203 64 62 42 139 255 246 233 41 155 132 116 77 196 108 174 57 157 142 114 168 109 154 207 124 132 219 85 54 88 167 203 116 246 71 177 73 119 74 111 174 106 248 191 237 250 174 41 47 221 39 115 191 23 159 167 189 62 254 223 207 143 119 239 106 243 125 122 117 116 15 251 79 131 138 203 221 54 149 175 28 237 254 198 124 86 152 47 94 95 57 241 248 102 185 39 143 11 246 139 87 86 95 106 222 243 243 219 213 215 95 223 108 103 175 84 191 255 219 99 246 226 123 197 21 137 156 218 81 187 119 45 154 38 168 217 88 127 52 96 119 238 78 237 214 94 31 237 166 151 102 151 55 220 40 208 158 61 249 93 196 194 35 59 107 242 79 25 79 155 54 247 239 180 205 194 145 158 87 24 227 239 22 220 88 252 250 180 141 208 140 155 146 51 110 202 206 144 228 61 115 133 201 248 183 178 220 178 95 11 88 62 57 109 180 208 110 16 232 225 190 191 176 182 209 55 169 113 230 222 123 47 191 136 101 181 219 55 127 114 48 89 113 109 211 18 155 39 219 214 123 220 201 46 127 209 187 224 237 244 223 11 214 190 125 43 24 36 123 182 243 168 112 231 145 3 151 46 124 221 248 243 225 206 100 110 247 245 61 49 126 42 110 250 114 251 77 234 116 39 74 236 89 245 167 254 178 222 28 123 83 75 211 226 178 95 119 102 222 188 108 254 143 233 208 207 45 89 182 192 4 142 179 84 103 101 228 74 129 23 85 132 75 98 54 80 14 7 21 166 28 162 156 130 28 2 188 194 220 66 60 124 98 252 226 34 236 18 0 254 125 218 6 28 7 0 0]
]

{ #category : #enumerating }
GTSpotterEventRecorderTest >> versionsDo: aBlock [
	self allPragmaVersions do: [ :eachPragmaVersion | | announcement |
		announcement := self materializePragmaVersion: eachPragmaVersion.
		aBlock cull: announcement cull: eachPragmaVersion selector.
	]
]
