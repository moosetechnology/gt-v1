Extension { #name : #GTSpotter }

{ #category : #'*Moose-Finder' }
GTSpotter >> spotterMooseModelsFor: aStep [
     <spotterOrder: 8>
     aStep listProcessor
               allCandidates: [:x | MooseModel root allModels ];
               title: 'Moose Models';
               itemName: [ :pragma | pragma name ];
               filterUsing: GTFilterSubstring;
               wantsToDisplayOnEmptyQuery: true
]
