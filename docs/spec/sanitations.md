_Author_: \
_Created_: 2026/07/22 \
_Updated_: 2026/07/22 \
_Edition_: Swan Lake

# Sanitation for OpenAPI specification

This document records the sanitation done on top of the official OpenAPI specification from Pricefx.
The OpenAPI specification is obtained from https://api.pricefx.com/openapi/reference/pricefx/.
These changes are done in order to improve the overall usability, and as workarounds for some known language limitations.

1. Change `InlineResponse2004ResponseData formulaDetailedResults` to nullable
- **Original**: The `formulaDetailedResults` field in `InlineResponse2004ResponseData` was `not nullable`.
- **Updated**: The `formulaDetailedResults` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

2. Change `CompensationViewState openFolders` to nullable
- **Original**: The `openFolders` field in `CompensationViewState` was `not nullable`.
- **Updated**: The `openFolders` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

3. Change `CompensationViewState gridViewState` to nullable
- **Original**: The `gridViewState` field in `CompensationViewState` was `not nullable`.
- **Updated**: The `gridViewState` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

4. Change `CompensationViewState selectedNodes` to nullable
- **Original**: The `selectedNodes` field in `CompensationViewState` was `not nullable`.
- **Updated**: The `selectedNodes` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

5. Change `InlineResponse2002ResponseData owner` to nullable
- **Original**: The `owner` field in `InlineResponse2002ResponseData` was `not nullable`.
- **Updated**: The `owner` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

6. Change `InlineResponse2002ResponseData data` to nullable
- **Original**: The `data` field in `InlineResponse2002ResponseData` was `not nullable`.
- **Updated**: The `data` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

7. Change `InlineResponse2008ResponseStateDefinitionScopeScope ProductMinMarginPercent` to nullable
- **Original**: The `ProductMinMarginPercent` field in `InlineResponse2008ResponseStateDefinitionScopeScope` was `not nullable`.
- **Updated**: The `ProductMinMarginPercent` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

8. Change `InlineResponse2008ResponseStateDefinitionScopeScope CustomerMinMarginPercent` to nullable
- **Original**: The `CustomerMinMarginPercent` field in `InlineResponse2008ResponseStateDefinitionScopeScope` was `not nullable`.
- **Updated**: The `CustomerMinMarginPercent` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

9. Change `InlineResponse2008ResponseStateDefinitionScopeScope CustomerMinRevenue` to nullable
- **Original**: The `CustomerMinRevenue` field in `InlineResponse2008ResponseStateDefinitionScopeScope` was `not nullable`.
- **Updated**: The `CustomerMinRevenue` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

10. Change `InlineResponse2008ResponseStateDefinitionScopeScope ProductMinRevenue` to nullable
- **Original**: The `ProductMinRevenue` field in `InlineResponse2008ResponseStateDefinitionScopeScope` was `not nullable`.
- **Updated**: The `ProductMinRevenue` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

11. Change `AddSLData userGroupEdit` to nullable
- **Original**: The `userGroupEdit` field in `AddSLData` was `not nullable`.
- **Updated**: The `userGroupEdit` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

12. Change `AddSLData userGroupViewDetails` to nullable
- **Original**: The `userGroupViewDetails` field in `AddSLData` was `not nullable`.
- **Updated**: The `userGroupViewDetails` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

13. Change `InlineResponse2008ResponseData approvedBy` to nullable
- **Original**: The `approvedBy` field in `InlineResponse2008ResponseData` was `not nullable`.
- **Updated**: The `approvedBy` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

14. Change `InlineResponse2008ResponseData submitDate` to nullable
- **Original**: The `submitDate` field in `InlineResponse2008ResponseData` was `not nullable`.
- **Updated**: The `submitDate` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

15. Change `InlineResponse2008ResponseData deniedByName` to nullable
- **Original**: The `deniedByName` field in `InlineResponse2008ResponseData` was `not nullable`.
- **Updated**: The `deniedByName` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

16. Change `InlineResponse2008ResponseData submittedByName` to nullable
- **Original**: The `submittedByName` field in `InlineResponse2008ResponseData` was `not nullable`.
- **Updated**: The `submittedByName` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

17. Change `InlineResponse2008ResponseData approvedByName` to nullable
- **Original**: The `approvedByName` field in `InlineResponse2008ResponseData` was `not nullable`.
- **Updated**: The `approvedByName` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

18. Change `InlineResponse2008ResponseData submittedBy` to nullable
- **Original**: The `submittedBy` field in `InlineResponse2008ResponseData` was `not nullable`.
- **Updated**: The `submittedBy` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

19. Change `InlineResponse2008ResponseData deniedBy` to nullable
- **Original**: The `deniedBy` field in `InlineResponse2008ResponseData` was `not nullable`.
- **Updated**: The `deniedBy` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

20. Change `QuoteTmpViewState openFolders` to nullable
- **Original**: The `openFolders` field in `QuoteTmpViewState` was `not nullable`.
- **Updated**: The `openFolders` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

21. Change `QuoteTmpViewState gridViewState` to nullable
- **Original**: The `gridViewState` field in `QuoteTmpViewState` was `not nullable`.
- **Updated**: The `gridViewState` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

22. Change `QuoteTmpViewState selectedNodes` to nullable
- **Original**: The `selectedNodes` field in `QuoteTmpViewState` was `not nullable`.
- **Updated**: The `selectedNodes` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

23. Change `SX10Inner attribute9` to nullable
- **Original**: The `attribute9` field in `SX10Inner` was `not nullable`.
- **Updated**: The `attribute9` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

24. Change `SX10Inner attribute8` to nullable
- **Original**: The `attribute8` field in `SX10Inner` was `not nullable`.
- **Updated**: The `attribute8` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

25. Change `SX10Inner attribute5` to nullable
- **Original**: The `attribute5` field in `SX10Inner` was `not nullable`.
- **Updated**: The `attribute5` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

26. Change `SX10Inner attribute4` to nullable
- **Original**: The `attribute4` field in `SX10Inner` was `not nullable`.
- **Updated**: The `attribute4` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

27. Change `SX10Inner attribute7` to nullable
- **Original**: The `attribute7` field in `SX10Inner` was `not nullable`.
- **Updated**: The `attribute7` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

28. Change `SX10Inner attribute6` to nullable
- **Original**: The `attribute6` field in `SX10Inner` was `not nullable`.
- **Updated**: The `attribute6` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

29. Change `SX10Inner attribute1` to nullable
- **Original**: The `attribute1` field in `SX10Inner` was `not nullable`.
- **Updated**: The `attribute1` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

30. Change `SX10Inner attribute3` to nullable
- **Original**: The `attribute3` field in `SX10Inner` was `not nullable`.
- **Updated**: The `attribute3` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

31. Change `SX10Inner attribute2` to nullable
- **Original**: The `attribute2` field in `SX10Inner` was `not nullable`.
- **Updated**: The `attribute2` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

32. Change `SX10Inner attribute10` to nullable
- **Original**: The `attribute10` field in `SX10Inner` was `not nullable`.
- **Updated**: The `attribute10` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

33. Change `InlineResponse20045ResponseWorkflowSteps userGroupNames` to nullable
- **Original**: The `userGroupNames` field in `InlineResponse20045ResponseWorkflowSteps` was `not nullable`.
- **Updated**: The `userGroupNames` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

34. Change `InlineResponse20045ResponseWorkflowSteps minApprovalsForGroups` to nullable
- **Original**: The `minApprovalsForGroups` field in `InlineResponse20045ResponseWorkflowSteps` was `not nullable`.
- **Updated**: The `minApprovalsForGroups` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

35. Change `InlineResponse20045ResponseWorkflowSteps isPostStepLogicFailed` to nullable
- **Original**: The `isPostStepLogicFailed` field in `InlineResponse20045ResponseWorkflowSteps` was `not nullable`.
- **Updated**: The `isPostStepLogicFailed` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

36. Change `InlineResponse20045ResponseWorkflowSteps postStepLogicName` to nullable
- **Original**: The `postStepLogicName` field in `InlineResponse20045ResponseWorkflowSteps` was `not nullable`.
- **Updated**: The `postStepLogicName` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

37. Change `InlineResponse20045ResponseWorkflowSteps userGroupTypedId` to nullable
- **Original**: The `userGroupTypedId` field in `InlineResponse20045ResponseWorkflowSteps` was `not nullable`.
- **Updated**: The `userGroupTypedId` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

38. Change `InlineResponse20045ResponseWorkflowSteps userGroupTypedIds` to nullable
- **Original**: The `userGroupTypedIds` field in `InlineResponse20045ResponseWorkflowSteps` was `not nullable`.
- **Updated**: The `userGroupTypedIds` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

39. Change `InlineResponse20045ResponseWorkflowSteps userGroupName` to nullable
- **Original**: The `userGroupName` field in `InlineResponse20045ResponseWorkflowSteps` was `not nullable`.
- **Updated**: The `userGroupName` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

40. Change `InlineResponse20045ResponseWorkflowSteps comment` to nullable
- **Original**: The `comment` field in `InlineResponse20045ResponseWorkflowSteps` was `not nullable`.
- **Updated**: The `comment` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

41. Change `InlineResponse20045ResponseWorkflowSteps mandatoryComments` to nullable
- **Original**: The `mandatoryComments` field in `InlineResponse20045ResponseWorkflowSteps` was `not nullable`.
- **Updated**: The `mandatoryComments` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

42. Change `FetchRRSCBody oldValues` to nullable
- **Original**: The `oldValues` field in `FetchRRSCBody` was `not nullable`.
- **Updated**: The `oldValues` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

43. Change `CustomformaddData userGroupEdit` to nullable
- **Original**: The `userGroupEdit` field in `CustomformaddData` was `not nullable`.
- **Updated**: The `userGroupEdit` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

44. Change `SellerInner attribute19` to nullable
- **Original**: The `attribute19` field in `SellerInner` was `not nullable`.
- **Updated**: The `attribute19` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

45. Change `SellerInner attribute18` to nullable
- **Original**: The `attribute18` field in `SellerInner` was `not nullable`.
- **Updated**: The `attribute18` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

46. Change `SellerInner attribute17` to nullable
- **Original**: The `attribute17` field in `SellerInner` was `not nullable`.
- **Updated**: The `attribute17` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

47. Change `SellerInner attribute16` to nullable
- **Original**: The `attribute16` field in `SellerInner` was `not nullable`.
- **Updated**: The `attribute16` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

48. Change `SellerInner attribute15` to nullable
- **Original**: The `attribute15` field in `SellerInner` was `not nullable`.
- **Updated**: The `attribute15` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

49. Change `SellerInner attribute25` to nullable
- **Original**: The `attribute25` field in `SellerInner` was `not nullable`.
- **Updated**: The `attribute25` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

50. Change `SellerInner attribute24` to nullable
- **Original**: The `attribute24` field in `SellerInner` was `not nullable`.
- **Updated**: The `attribute24` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

51. Change `SellerInner userGroupViewDetails` to nullable
- **Original**: The `userGroupViewDetails` field in `SellerInner` was `not nullable`.
- **Updated**: The `userGroupViewDetails` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

52. Change `SellerInner attribute23` to nullable
- **Original**: The `attribute23` field in `SellerInner` was `not nullable`.
- **Updated**: The `attribute23` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

53. Change `SellerInner attribute22` to nullable
- **Original**: The `attribute22` field in `SellerInner` was `not nullable`.
- **Updated**: The `attribute22` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

54. Change `SellerInner attribute21` to nullable
- **Original**: The `attribute21` field in `SellerInner` was `not nullable`.
- **Updated**: The `attribute21` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

55. Change `SellerInner attribute20` to nullable
- **Original**: The `attribute20` field in `SellerInner` was `not nullable`.
- **Updated**: The `attribute20` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

56. Change `SellerInner attribute29` to nullable
- **Original**: The `attribute29` field in `SellerInner` was `not nullable`.
- **Updated**: The `attribute29` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

57. Change `SellerInner attribute28` to nullable
- **Original**: The `attribute28` field in `SellerInner` was `not nullable`.
- **Updated**: The `attribute28` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

58. Change `SellerInner attribute27` to nullable
- **Original**: The `attribute27` field in `SellerInner` was `not nullable`.
- **Updated**: The `attribute27` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

59. Change `SellerInner attribute26` to nullable
- **Original**: The `attribute26` field in `SellerInner` was `not nullable`.
- **Updated**: The `attribute26` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

60. Change `SellerInner reportsTo` to nullable
- **Original**: The `reportsTo` field in `SellerInner` was `not nullable`.
- **Updated**: The `reportsTo` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

61. Change `SellerInner attribute9` to nullable
- **Original**: The `attribute9` field in `SellerInner` was `not nullable`.
- **Updated**: The `attribute9` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

62. Change `SellerInner attribute8` to nullable
- **Original**: The `attribute8` field in `SellerInner` was `not nullable`.
- **Updated**: The `attribute8` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

63. Change `SellerInner attribute5` to nullable
- **Original**: The `attribute5` field in `SellerInner` was `not nullable`.
- **Updated**: The `attribute5` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

64. Change `SellerInner attribute4` to nullable
- **Original**: The `attribute4` field in `SellerInner` was `not nullable`.
- **Updated**: The `attribute4` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

65. Change `SellerInner attribute7` to nullable
- **Original**: The `attribute7` field in `SellerInner` was `not nullable`.
- **Updated**: The `attribute7` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

66. Change `SellerInner attribute6` to nullable
- **Original**: The `attribute6` field in `SellerInner` was `not nullable`.
- **Updated**: The `attribute6` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

67. Change `SellerInner attribute1` to nullable
- **Original**: The `attribute1` field in `SellerInner` was `not nullable`.
- **Updated**: The `attribute1` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

68. Change `SellerInner attribute14` to nullable
- **Original**: The `attribute14` field in `SellerInner` was `not nullable`.
- **Updated**: The `attribute14` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

69. Change `SellerInner attribute13` to nullable
- **Original**: The `attribute13` field in `SellerInner` was `not nullable`.
- **Updated**: The `attribute13` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

70. Change `SellerInner userGroupEdit` to nullable
- **Original**: The `userGroupEdit` field in `SellerInner` was `not nullable`.
- **Updated**: The `userGroupEdit` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

71. Change `SellerInner attribute3` to nullable
- **Original**: The `attribute3` field in `SellerInner` was `not nullable`.
- **Updated**: The `attribute3` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

72. Change `SellerInner attribute12` to nullable
- **Original**: The `attribute12` field in `SellerInner` was `not nullable`.
- **Updated**: The `attribute12` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

73. Change `SellerInner attribute2` to nullable
- **Original**: The `attribute2` field in `SellerInner` was `not nullable`.
- **Updated**: The `attribute2` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

74. Change `SellerInner attribute11` to nullable
- **Original**: The `attribute11` field in `SellerInner` was `not nullable`.
- **Updated**: The `attribute11` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

75. Change `SellerInner attribute10` to nullable
- **Original**: The `attribute10` field in `SellerInner` was `not nullable`.
- **Updated**: The `attribute10` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

76. Change `SellerInner attribute30` to nullable
- **Original**: The `attribute30` field in `SellerInner` was `not nullable`.
- **Updated**: The `attribute30` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

77. Change `InlineResponse2013ResponseData originalValue` to nullable
- **Original**: The `originalValue` field in `InlineResponse2013ResponseData` was `not nullable`.
- **Updated**: The `originalValue` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

78. Change `InlineResponse2013ResponseData validationErrors` to nullable
- **Original**: The `validationErrors` field in `InlineResponse2013ResponseData` was `not nullable`.
- **Updated**: The `validationErrors` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

79. Change `CommentmanagerFetchthreadstypedIdBody oldValues` to nullable
- **Original**: The `oldValues` field in `CommentmanagerFetchthreadstypedIdBody` was `not nullable`.
- **Updated**: The `oldValues` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

80. Change `GetCLICrequest oldValues` to nullable
- **Original**: The `oldValues` field in `GetCLICrequest` was `not nullable`.
- **Updated**: The `oldValues` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

81. Change `DcrmanageraddmassopidDataMassEditRecords precision` to nullable
- **Original**: The `precision` field in `DcrmanageraddmassopidDataMassEditRecords` was `not nullable`.
- **Updated**: The `precision` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

82. Change `CustomFormParameterConfig property2` to nullable
- **Original**: The `property2` field in `CustomFormParameterConfig` was `not nullable`.
- **Updated**: The `property2` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

83. Change `CustomFormParameterConfig property1` to nullable
- **Original**: The `property1` field in `CustomFormParameterConfig` was `not nullable`.
- **Updated**: The `property1` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

84. Change `QuoteTmp outputs` to nullable
- **Original**: The `outputs` field in `QuoteTmp` was `not nullable`.
- **Updated**: The `outputs` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

85. Change `QuoteTmp headerText` to nullable
- **Original**: The `headerText` field in `QuoteTmp` was `not nullable`.
- **Updated**: The `headerText` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

86. Change `QuoteTmp inputs` to nullable
- **Original**: The `inputs` field in `QuoteTmp` was `not nullable`.
- **Updated**: The `inputs` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

87. Change `QuoteTmp serverMessagesExtended` to nullable
- **Original**: The `serverMessagesExtended` field in `QuoteTmp` was `not nullable`.
- **Updated**: The `serverMessagesExtended` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

88. Change `QuoteTmp externalRef` to nullable
- **Original**: The `externalRef` field in `QuoteTmp` was `not nullable`.
- **Updated**: The `externalRef` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

89. Change `QuoteTmp deniedByName` to nullable
- **Original**: The `deniedByName` field in `QuoteTmp` was `not nullable`.
- **Updated**: The `deniedByName` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

90. Change `QuoteTmp userGroupViewDetails` to nullable
- **Original**: The `userGroupViewDetails` field in `QuoteTmp` was `not nullable`.
- **Updated**: The `userGroupViewDetails` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

91. Change `QuoteTmp approvedByName` to nullable
- **Original**: The `approvedByName` field in `QuoteTmp` was `not nullable`.
- **Updated**: The `approvedByName` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

92. Change `QuoteTmp creationWorkflowCurrentStep` to nullable
- **Original**: The `creationWorkflowCurrentStep` field in `QuoteTmp` was `not nullable`.
- **Updated**: The `creationWorkflowCurrentStep` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

93. Change `QuoteTmp originUniqueName` to nullable
- **Original**: The `originUniqueName` field in `QuoteTmp` was `not nullable`.
- **Updated**: The `originUniqueName` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

94. Change `QuoteTmp targetDate` to nullable
- **Original**: The `targetDate` field in `QuoteTmp` was `not nullable`.
- **Updated**: The `targetDate` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

95. Change `QuoteTmp customerGroup` to nullable
- **Original**: The `customerGroup` field in `QuoteTmp` was `not nullable`.
- **Updated**: The `customerGroup` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

96. Change `QuoteTmp ioMeta` to nullable
- **Original**: The `ioMeta` field in `QuoteTmp` was `not nullable`.
- **Updated**: The `ioMeta` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

97. Change `QuoteTmp originDeleted` to nullable
- **Original**: The `originDeleted` field in `QuoteTmp` was `not nullable`.
- **Updated**: The `originDeleted` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

98. Change `QuoteTmp customerName` to nullable
- **Original**: The `customerName` field in `QuoteTmp` was `not nullable`.
- **Updated**: The `customerName` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

99. Change `QuoteTmp serverMessages` to nullable
- **Original**: The `serverMessages` field in `QuoteTmp` was `not nullable`.
- **Updated**: The `serverMessages` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

100. Change `QuoteTmp userGroupEdit` to nullable
- **Original**: The `userGroupEdit` field in `QuoteTmp` was `not nullable`.
- **Updated**: The `userGroupEdit` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

101. Change `QuoteTmp originClicId` to nullable
- **Original**: The `originClicId` field in `QuoteTmp` was `not nullable`.
- **Updated**: The `originClicId` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

102. Change `QuoteTmp renderInfo` to nullable
- **Original**: The `renderInfo` field in `QuoteTmp` was `not nullable`.
- **Updated**: The `renderInfo` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

103. Change `QuoteTmp lostReason` to nullable
- **Original**: The `lostReason` field in `QuoteTmp` was `not nullable`.
- **Updated**: The `lostReason` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

104. Change `QuoteTmp creationWorkflowStepCount` to nullable
- **Original**: The `creationWorkflowStepCount` field in `QuoteTmp` was `not nullable`.
- **Updated**: The `creationWorkflowStepCount` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

105. Change `QuoteTmp quoteType` to nullable
- **Original**: The `quoteType` field in `QuoteTmp` was `not nullable`.
- **Updated**: The `quoteType` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

106. Change `QuoteTmp lostReasonComment` to nullable
- **Original**: The `lostReasonComment` field in `QuoteTmp` was `not nullable`.
- **Updated**: The `lostReasonComment` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

107. Change `QuoteTmp expiryDate` to nullable
- **Original**: The `expiryDate` field in `QuoteTmp` was `not nullable`.
- **Updated**: The `expiryDate` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

108. Change `QuoteTmp creationWorkflowStepLabel` to nullable
- **Original**: The `creationWorkflowStepLabel` field in `QuoteTmp` was `not nullable`.
- **Updated**: The `creationWorkflowStepLabel` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

109. Change `QuoteTmp customerId` to nullable
- **Original**: The `customerId` field in `QuoteTmp` was `not nullable`.
- **Updated**: The `customerId` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

110. Change `QuoteTmp submittedByName` to nullable
- **Original**: The `submittedByName` field in `QuoteTmp` was `not nullable`.
- **Updated**: The `submittedByName` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

111. Change `QuoteTmp additionalInfo4` to nullable
- **Original**: The `additionalInfo4` field in `QuoteTmp` was `not nullable`.
- **Updated**: The `additionalInfo4` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

112. Change `QuoteTmp additionalInfo3` to nullable
- **Original**: The `additionalInfo3` field in `QuoteTmp` was `not nullable`.
- **Updated**: The `additionalInfo3` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

113. Change `QuoteTmp additionalInfo2` to nullable
- **Original**: The `additionalInfo2` field in `QuoteTmp` was `not nullable`.
- **Updated**: The `additionalInfo2` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

114. Change `QuoteTmp additionalInfo1` to nullable
- **Original**: The `additionalInfo1` field in `QuoteTmp` was `not nullable`.
- **Updated**: The `additionalInfo1` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

115. Change `QuoteTmp originLabel` to nullable
- **Original**: The `originLabel` field in `QuoteTmp` was `not nullable`.
- **Updated**: The `originLabel` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

116. Change `QuoteTmp approvalRequiredEmailAttachmentsJson` to nullable
- **Original**: The `approvalRequiredEmailAttachmentsJson` field in `QuoteTmp` was `not nullable`.
- **Updated**: The `approvalRequiredEmailAttachmentsJson` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

117. Change `QuoteTmp prevRev` to nullable
- **Original**: The `prevRev` field in `QuoteTmp` was `not nullable`.
- **Updated**: The `prevRev` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

118. Change `QuoteTmp supersededBy` to nullable
- **Original**: The `supersededBy` field in `QuoteTmp` was `not nullable`.
- **Updated**: The `supersededBy` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

119. Change `ExecuteActionItemLogicResponseResponseData alertMessage` to nullable
- **Original**: The `alertMessage` field in `ExecuteActionItemLogicResponseResponseData` was `not nullable`.
- **Updated**: The `alertMessage` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

120. Change `ExecuteActionItemLogicResponseResponseData cssProperties` to nullable
- **Original**: The `cssProperties` field in `ExecuteActionItemLogicResponseResponseData` was `not nullable`.
- **Updated**: The `cssProperties` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

121. Change `ExecuteActionItemLogicResponseResponseData labelTranslations` to nullable
- **Original**: The `labelTranslations` field in `ExecuteActionItemLogicResponseResponseData` was `not nullable`.
- **Updated**: The `labelTranslations` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

122. Change `ExecuteActionItemLogicResponseResponseData alertType` to nullable
- **Original**: The `alertType` field in `ExecuteActionItemLogicResponseResponseData` was `not nullable`.
- **Updated**: The `alertType` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

123. Change `ExecuteActionItemLogicResponseResponseData overrideValueOptions` to nullable
- **Original**: The `overrideValueOptions` field in `ExecuteActionItemLogicResponseResponseData` was `not nullable`.
- **Updated**: The `overrideValueOptions` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

124. Change `ExecuteActionItemLogicResponseResponseData warnings` to nullable
- **Original**: The `warnings` field in `ExecuteActionItemLogicResponseResponseData` was `not nullable`.
- **Updated**: The `warnings` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

125. Change `ExecuteActionItemLogicResponseResponseData resultGroup` to nullable
- **Original**: The `resultGroup` field in `ExecuteActionItemLogicResponseResponseData` was `not nullable`.
- **Updated**: The `resultGroup` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

126. Change `ExecuteActionItemLogicResponseResponseData suffix` to nullable
- **Original**: The `suffix` field in `ExecuteActionItemLogicResponseResponseData` was `not nullable`.
- **Updated**: The `suffix` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

127. Change `ExecuteActionItemLogicResponseResponseData result` to nullable
- **Original**: The `result` field in `ExecuteActionItemLogicResponseResponseData` was `not nullable`.
- **Updated**: The `result` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

128. Change `ExecuteActionItemLogicResponseResponseData resultDescription` to nullable
- **Original**: The `resultDescription` field in `ExecuteActionItemLogicResponseResponseData` was `not nullable`.
- **Updated**: The `resultDescription` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

129. Change `ExecuteActionItemLogicResponseResponseData formatType` to nullable
- **Original**: The `formatType` field in `ExecuteActionItemLogicResponseResponseData` was `not nullable`.
- **Updated**: The `formatType` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

130. Change `ExecuteActionItemLogicResponseResponseData userGroup` to nullable
- **Original**: The `userGroup` field in `ExecuteActionItemLogicResponseResponseData` was `not nullable`.
- **Updated**: The `userGroup` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

131. Change `FetchJCSBody oldValues` to nullable
- **Original**: The `oldValues` field in `FetchJCSBody` was `not nullable`.
- **Updated**: The `oldValues` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

132. Change `CompensationRecordSetCalculationCalculationConfig formulaName` to nullable
- **Original**: The `formulaName` field in `CompensationRecordSetCalculationCalculationConfig` was `not nullable`.
- **Updated**: The `formulaName` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

133. Change `CompensationRecordSetCalculationCalculationConfig feederFormulaName` to nullable
- **Original**: The `feederFormulaName` field in `CompensationRecordSetCalculationCalculationConfig` was `not nullable`.
- **Updated**: The `feederFormulaName` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

134. Change `CompensationRecordSetCalculationCalculationConfig simulationSet` to nullable
- **Original**: The `simulationSet` field in `CompensationRecordSetCalculationCalculationConfig` was `not nullable`.
- **Updated**: The `simulationSet` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

135. Change `CompensationRecordSetCalculationCalculationConfig targetDate` to nullable
- **Original**: The `targetDate` field in `CompensationRecordSetCalculationCalculationConfig` was `not nullable`.
- **Updated**: The `targetDate` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

136. Change `CompensationRecordSetCalculationCalculationConfig skuField` to nullable
- **Original**: The `skuField` field in `CompensationRecordSetCalculationCalculationConfig` was `not nullable`.
- **Updated**: The `skuField` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

137. Change `CompensationRecordSetCalculationCalculationConfig targetDateField` to nullable
- **Original**: The `targetDateField` field in `CompensationRecordSetCalculationCalculationConfig` was `not nullable`.
- **Updated**: The `targetDateField` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

138. Change `CompensationRecordSetCalculationCalculationConfig targetFields` to nullable
- **Original**: The `targetFields` field in `CompensationRecordSetCalculationCalculationConfig` was `not nullable`.
- **Updated**: The `targetFields` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

139. Change `SaveRebateCalculationRequest oldValues` to nullable
- **Original**: The `oldValues` field in `SaveRebateCalculationRequest` was `not nullable`.
- **Updated**: The `oldValues` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

140. Change `InlineResponse20034ResponseData lastUpdateByName` to nullable
- **Original**: The `lastUpdateByName` field in `InlineResponse20034ResponseData` was `not nullable`.
- **Updated**: The `lastUpdateByName` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

141. Change `InlineResponse20034ResponseData sender` to nullable
- **Original**: The `sender` field in `InlineResponse20034ResponseData` was `not nullable`.
- **Updated**: The `sender` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

142. Change `InlineResponse20034ResponseData recipients` to nullable
- **Original**: The `recipients` field in `InlineResponse20034ResponseData` was `not nullable`.
- **Updated**: The `recipients` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

143. Change `InlineResponse20034ResponseData userGroupEdit` to nullable
- **Original**: The `userGroupEdit` field in `InlineResponse20034ResponseData` was `not nullable`.
- **Updated**: The `userGroupEdit` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

144. Change `InlineResponse20034ResponseData userGroupViewDetails` to nullable
- **Original**: The `userGroupViewDetails` field in `InlineResponse20034ResponseData` was `not nullable`.
- **Updated**: The `userGroupViewDetails` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

145. Change `InlineResponse20034ResponseData embeddedOwner` to nullable
- **Original**: The `embeddedOwner` field in `InlineResponse20034ResponseData` was `not nullable`.
- **Updated**: The `embeddedOwner` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

146. Change `InlineResponse20045ResponseWorkflow submitReason` to nullable
- **Original**: The `submitReason` field in `InlineResponse20045ResponseWorkflow` was `not nullable`.
- **Updated**: The `submitReason` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

147. Change `InlineResponse20045ResponseWorkflow submitterUserName` to nullable
- **Original**: The `submitterUserName` field in `InlineResponse20045ResponseWorkflow` was `not nullable`.
- **Updated**: The `submitterUserName` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

148. Change `InlineResponse20045ResponseWorkflow submitterTypedId` to nullable
- **Original**: The `submitterTypedId` field in `InlineResponse20045ResponseWorkflow` was `not nullable`.
- **Updated**: The `submitterTypedId` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

149. Change `CompensationRecordCalculationResults alertMessage` to nullable
- **Original**: The `alertMessage` field in `CompensationRecordCalculationResults` was `not nullable`.
- **Updated**: The `alertMessage` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

150. Change `CompensationRecordCalculationResults cssProperties` to nullable
- **Original**: The `cssProperties` field in `CompensationRecordCalculationResults` was `not nullable`.
- **Updated**: The `cssProperties` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

151. Change `CompensationRecordCalculationResults labelTranslations` to nullable
- **Original**: The `labelTranslations` field in `CompensationRecordCalculationResults` was `not nullable`.
- **Updated**: The `labelTranslations` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

152. Change `CompensationRecordCalculationResults alertType` to nullable
- **Original**: The `alertType` field in `CompensationRecordCalculationResults` was `not nullable`.
- **Updated**: The `alertType` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

153. Change `CompensationRecordCalculationResults overrideValueOptions` to nullable
- **Original**: The `overrideValueOptions` field in `CompensationRecordCalculationResults` was `not nullable`.
- **Updated**: The `overrideValueOptions` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

154. Change `CompensationRecordCalculationResults warnings` to nullable
- **Original**: The `warnings` field in `CompensationRecordCalculationResults` was `not nullable`.
- **Updated**: The `warnings` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

155. Change `CompensationRecordCalculationResults resultGroup` to nullable
- **Original**: The `resultGroup` field in `CompensationRecordCalculationResults` was `not nullable`.
- **Updated**: The `resultGroup` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

156. Change `CompensationRecordCalculationResults suffix` to nullable
- **Original**: The `suffix` field in `CompensationRecordCalculationResults` was `not nullable`.
- **Updated**: The `suffix` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

157. Change `CompensationRecordCalculationResults resultDescription` to nullable
- **Original**: The `resultDescription` field in `CompensationRecordCalculationResults` was `not nullable`.
- **Updated**: The `resultDescription` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

158. Change `CompensationRecordCalculationResults userGroup` to nullable
- **Original**: The `userGroup` field in `CompensationRecordCalculationResults` was `not nullable`.
- **Updated**: The `userGroup` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

159. Change `SX30Inner attribute19` to nullable
- **Original**: The `attribute19` field in `SX30Inner` was `not nullable`.
- **Updated**: The `attribute19` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

160. Change `SX30Inner attribute18` to nullable
- **Original**: The `attribute18` field in `SX30Inner` was `not nullable`.
- **Updated**: The `attribute18` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

161. Change `SX30Inner attribute17` to nullable
- **Original**: The `attribute17` field in `SX30Inner` was `not nullable`.
- **Updated**: The `attribute17` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

162. Change `SX30Inner attribute16` to nullable
- **Original**: The `attribute16` field in `SX30Inner` was `not nullable`.
- **Updated**: The `attribute16` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

163. Change `SX30Inner attribute15` to nullable
- **Original**: The `attribute15` field in `SX30Inner` was `not nullable`.
- **Updated**: The `attribute15` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

164. Change `SX30Inner attribute25` to nullable
- **Original**: The `attribute25` field in `SX30Inner` was `not nullable`.
- **Updated**: The `attribute25` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

165. Change `SX30Inner attribute24` to nullable
- **Original**: The `attribute24` field in `SX30Inner` was `not nullable`.
- **Updated**: The `attribute24` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

166. Change `SX30Inner attribute23` to nullable
- **Original**: The `attribute23` field in `SX30Inner` was `not nullable`.
- **Updated**: The `attribute23` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

167. Change `SX30Inner attribute22` to nullable
- **Original**: The `attribute22` field in `SX30Inner` was `not nullable`.
- **Updated**: The `attribute22` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

168. Change `SX30Inner attribute21` to nullable
- **Original**: The `attribute21` field in `SX30Inner` was `not nullable`.
- **Updated**: The `attribute21` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

169. Change `SX30Inner attribute20` to nullable
- **Original**: The `attribute20` field in `SX30Inner` was `not nullable`.
- **Updated**: The `attribute20` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

170. Change `SX30Inner attribute29` to nullable
- **Original**: The `attribute29` field in `SX30Inner` was `not nullable`.
- **Updated**: The `attribute29` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

171. Change `SX30Inner attribute28` to nullable
- **Original**: The `attribute28` field in `SX30Inner` was `not nullable`.
- **Updated**: The `attribute28` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

172. Change `SX30Inner attribute27` to nullable
- **Original**: The `attribute27` field in `SX30Inner` was `not nullable`.
- **Updated**: The `attribute27` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

173. Change `SX30Inner attribute26` to nullable
- **Original**: The `attribute26` field in `SX30Inner` was `not nullable`.
- **Updated**: The `attribute26` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

174. Change `SX30Inner attribute9` to nullable
- **Original**: The `attribute9` field in `SX30Inner` was `not nullable`.
- **Updated**: The `attribute9` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

175. Change `SX30Inner attribute8` to nullable
- **Original**: The `attribute8` field in `SX30Inner` was `not nullable`.
- **Updated**: The `attribute8` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

176. Change `SX30Inner attribute5` to nullable
- **Original**: The `attribute5` field in `SX30Inner` was `not nullable`.
- **Updated**: The `attribute5` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

177. Change `SX30Inner attribute4` to nullable
- **Original**: The `attribute4` field in `SX30Inner` was `not nullable`.
- **Updated**: The `attribute4` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

178. Change `SX30Inner attribute7` to nullable
- **Original**: The `attribute7` field in `SX30Inner` was `not nullable`.
- **Updated**: The `attribute7` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

179. Change `SX30Inner attribute6` to nullable
- **Original**: The `attribute6` field in `SX30Inner` was `not nullable`.
- **Updated**: The `attribute6` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

180. Change `SX30Inner attribute1` to nullable
- **Original**: The `attribute1` field in `SX30Inner` was `not nullable`.
- **Updated**: The `attribute1` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

181. Change `SX30Inner attribute14` to nullable
- **Original**: The `attribute14` field in `SX30Inner` was `not nullable`.
- **Updated**: The `attribute14` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

182. Change `SX30Inner attribute13` to nullable
- **Original**: The `attribute13` field in `SX30Inner` was `not nullable`.
- **Updated**: The `attribute13` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

183. Change `SX30Inner attribute3` to nullable
- **Original**: The `attribute3` field in `SX30Inner` was `not nullable`.
- **Updated**: The `attribute3` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

184. Change `SX30Inner attribute12` to nullable
- **Original**: The `attribute12` field in `SX30Inner` was `not nullable`.
- **Updated**: The `attribute12` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

185. Change `SX30Inner attribute2` to nullable
- **Original**: The `attribute2` field in `SX30Inner` was `not nullable`.
- **Updated**: The `attribute2` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

186. Change `SX30Inner attribute11` to nullable
- **Original**: The `attribute11` field in `SX30Inner` was `not nullable`.
- **Updated**: The `attribute11` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

187. Change `SX30Inner attribute10` to nullable
- **Original**: The `attribute10` field in `SX30Inner` was `not nullable`.
- **Updated**: The `attribute10` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

188. Change `SX30Inner attribute30` to nullable
- **Original**: The `attribute30` field in `SX30Inner` was `not nullable`.
- **Updated**: The `attribute30` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

189. Change `CompensationRecordCalculationBaseAsAdvancedFilterCriteria _constructor` to nullable
- **Original**: The `_constructor` field in `CompensationRecordCalculationBaseAsAdvancedFilterCriteria` was `not nullable`.
- **Updated**: The `_constructor` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

190. Change `InlineResponse20045ResponseData layout` to nullable
- **Original**: The `layout` field in `InlineResponse20045ResponseData` was `not nullable`.
- **Updated**: The `layout` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

191. Change `UpdateCOCTOldValues formulaName` to nullable
- **Original**: The `formulaName` field in `UpdateCOCTOldValues` was `not nullable`.
- **Updated**: The `formulaName` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

192. Change `UpdateCOCTOldValues userGroupViewDetails` to nullable
- **Original**: The `userGroupViewDetails` field in `UpdateCOCTOldValues` was `not nullable`.
- **Updated**: The `userGroupViewDetails` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

193. Change `UpdateCOCTOldValues waterfallElement` to nullable
- **Original**: The `waterfallElement` field in `UpdateCOCTOldValues` was `not nullable`.
- **Updated**: The `waterfallElement` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

194. Change `UpdateCOCTOldValues userGroupEdit` to nullable
- **Original**: The `userGroupEdit` field in `UpdateCOCTOldValues` was `not nullable`.
- **Updated**: The `userGroupEdit` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

195. Change `DcrmanagerupdatemassopidDataMassChangeDefinitions precision` to nullable
- **Original**: The `precision` field in `DcrmanagerupdatemassopidDataMassChangeDefinitions` was `not nullable`.
- **Updated**: The `precision` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

196. Change `ClaimTypeConfigurationColumnsSku fieldFormatType` to nullable
- **Original**: The `fieldFormatType` field in `ClaimTypeConfigurationColumnsSku` was `not nullable`.
- **Updated**: The `fieldFormatType` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

197. Change `ClaimTypeConfigurationColumnsSku name` to nullable
- **Original**: The `name` field in `ClaimTypeConfigurationColumnsSku` was `not nullable`.
- **Updated**: The `name` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

198. Change `UpdateCLTDataConfigurationColumnsSku fieldFormatType` to nullable
- **Original**: The `fieldFormatType` field in `UpdateCLTDataConfigurationColumnsSku` was `not nullable`.
- **Updated**: The `fieldFormatType` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

199. Change `UpdateCLTDataConfigurationColumnsSku name` to nullable
- **Original**: The `name` field in `UpdateCLTDataConfigurationColumnsSku` was `not nullable`.
- **Updated**: The `name` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

200. Change `ListClaimTypesRequest oldValues` to nullable
- **Original**: The `oldValues` field in `ListClaimTypesRequest` was `not nullable`.
- **Updated**: The `oldValues` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

201. Change `AddCOHTData configuration` to nullable
- **Original**: The `configuration` field in `AddCOHTData` was `not nullable`.
- **Updated**: The `configuration` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

202. Change `RebateRecordGroupCalculationResults alertMessage` to nullable
- **Original**: The `alertMessage` field in `RebateRecordGroupCalculationResults` was `not nullable`.
- **Updated**: The `alertMessage` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

203. Change `RebateRecordGroupCalculationResults cssProperties` to nullable
- **Original**: The `cssProperties` field in `RebateRecordGroupCalculationResults` was `not nullable`.
- **Updated**: The `cssProperties` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

204. Change `RebateRecordGroupCalculationResults labelTranslations` to nullable
- **Original**: The `labelTranslations` field in `RebateRecordGroupCalculationResults` was `not nullable`.
- **Updated**: The `labelTranslations` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

205. Change `RebateRecordGroupCalculationResults overrideValueOptions` to nullable
- **Original**: The `overrideValueOptions` field in `RebateRecordGroupCalculationResults` was `not nullable`.
- **Updated**: The `overrideValueOptions` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

206. Change `RebateRecordGroupCalculationResults warnings` to nullable
- **Original**: The `warnings` field in `RebateRecordGroupCalculationResults` was `not nullable`.
- **Updated**: The `warnings` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

207. Change `RebateRecordGroupCalculationResults resultGroup` to nullable
- **Original**: The `resultGroup` field in `RebateRecordGroupCalculationResults` was `not nullable`.
- **Updated**: The `resultGroup` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

208. Change `RebateRecordGroupCalculationResults suffix` to nullable
- **Original**: The `suffix` field in `RebateRecordGroupCalculationResults` was `not nullable`.
- **Updated**: The `suffix` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

209. Change `RebateRecordGroupCalculationResults resultDescription` to nullable
- **Original**: The `resultDescription` field in `RebateRecordGroupCalculationResults` was `not nullable`.
- **Updated**: The `resultDescription` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

210. Change `RebateRecordGroupCalculationResults formatType` to nullable
- **Original**: The `formatType` field in `RebateRecordGroupCalculationResults` was `not nullable`.
- **Updated**: The `formatType` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

211. Change `RebateRecordGroupCalculationResults userGroup` to nullable
- **Original**: The `userGroup` field in `RebateRecordGroupCalculationResults` was `not nullable`.
- **Updated**: The `userGroup` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

212. Change `ListAccrualRecordsRequest oldValues` to nullable
- **Original**: The `oldValues` field in `ListAccrualRecordsRequest` was `not nullable`.
- **Updated**: The `oldValues` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

213. Change `InlineResponse2003ResponseViewState openFolders` to nullable
- **Original**: The `openFolders` field in `InlineResponse2003ResponseViewState` was `not nullable`.
- **Updated**: The `openFolders` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

214. Change `InlineResponse2003ResponseViewState gridViewState` to nullable
- **Original**: The `gridViewState` field in `InlineResponse2003ResponseViewState` was `not nullable`.
- **Updated**: The `gridViewState` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

215. Change `InlineResponse2003ResponseViewState validationSnapshot` to nullable
- **Original**: The `validationSnapshot` field in `InlineResponse2003ResponseViewState` was `not nullable`.
- **Updated**: The `validationSnapshot` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

216. Change `BdmanagerListtypedIdBody oldValues` to nullable
- **Original**: The `oldValues` field in `BdmanagerListtypedIdBody` was `not nullable`.
- **Updated**: The `oldValues` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

217. Change `RebateRecordSetCalculationRebateRecordSet updateDate` to nullable
- **Original**: The `updateDate` field in `RebateRecordSetCalculationRebateRecordSet` was `not nullable`.
- **Updated**: The `updateDate` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

218. Change `RebateRecordSetCalculationRebateRecordSet calculationMessages` to nullable
- **Original**: The `calculationMessages` field in `RebateRecordSetCalculationRebateRecordSet` was `not nullable`.
- **Updated**: The `calculationMessages` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

219. Change `RebateRecordSetCalculationRebateRecordSet targetDate` to nullable
- **Original**: The `targetDate` field in `RebateRecordSetCalculationRebateRecordSet` was `not nullable`.
- **Updated**: The `targetDate` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

220. Change `RebateRecordSetCalculationRebateRecordSet locale` to nullable
- **Original**: The `locale` field in `RebateRecordSetCalculationRebateRecordSet` was `not nullable`.
- **Updated**: The `locale` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

221. Change `RebateRecordSetCalculationRebateRecordSet calculationDate` to nullable
- **Original**: The `calculationDate` field in `RebateRecordSetCalculationRebateRecordSet` was `not nullable`.
- **Updated**: The `calculationDate` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

222. Change `RebateRecordSetCalculationRebateRecordSet userGroupEdit` to nullable
- **Original**: The `userGroupEdit` field in `RebateRecordSetCalculationRebateRecordSet` was `not nullable`.
- **Updated**: The `userGroupEdit` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

223. Change `RebateRecordSetCalculationRebateRecordSet userGroupViewDetails` to nullable
- **Original**: The `userGroupViewDetails` field in `RebateRecordSetCalculationRebateRecordSet` was `not nullable`.
- **Updated**: The `userGroupViewDetails` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

224. Change `RebateRecordSetCalculationRebateRecordSet calculationStartDate` to nullable
- **Original**: The `calculationStartDate` field in `RebateRecordSetCalculationRebateRecordSet` was `not nullable`.
- **Updated**: The `calculationStartDate` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

225. Change `SX6Inner attribute5` to nullable
- **Original**: The `attribute5` field in `SX6Inner` was `not nullable`.
- **Updated**: The `attribute5` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

226. Change `SX6Inner attribute4` to nullable
- **Original**: The `attribute4` field in `SX6Inner` was `not nullable`.
- **Updated**: The `attribute4` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

227. Change `SX6Inner attribute6` to nullable
- **Original**: The `attribute6` field in `SX6Inner` was `not nullable`.
- **Updated**: The `attribute6` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

228. Change `SX6Inner attribute1` to nullable
- **Original**: The `attribute1` field in `SX6Inner` was `not nullable`.
- **Updated**: The `attribute1` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

229. Change `SX6Inner attribute3` to nullable
- **Original**: The `attribute3` field in `SX6Inner` was `not nullable`.
- **Updated**: The `attribute3` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

230. Change `SX6Inner attribute2` to nullable
- **Original**: The `attribute2` field in `SX6Inner` was `not nullable`.
- **Updated**: The `attribute2` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

231. Change `InlineResponse2008ResponseJobSettings queueName` to nullable
- **Original**: The `queueName` field in `InlineResponse2008ResponseJobSettings` was `not nullable`.
- **Updated**: The `queueName` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

232. Change `InlineResponse2008ResponseJobSettings distributedAction` to nullable
- **Original**: The `distributedAction` field in `InlineResponse2008ResponseJobSettings` was `not nullable`.
- **Updated**: The `distributedAction` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

233. Change `ListCompensationPlansRequest oldValues` to nullable
- **Original**: The `oldValues` field in `ListCompensationPlansRequest` was `not nullable`.
- **Updated**: The `oldValues` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

234. Change `RecalculateCalculationOfStepResponseResponseData approvedBy` to nullable
- **Original**: The `approvedBy` field in `RecalculateCalculationOfStepResponseResponseData` was `not nullable`.
- **Updated**: The `approvedBy` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

235. Change `RecalculateCalculationOfStepResponseResponseData submitDate` to nullable
- **Original**: The `submitDate` field in `RecalculateCalculationOfStepResponseResponseData` was `not nullable`.
- **Updated**: The `submitDate` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

236. Change `RecalculateCalculationOfStepResponseResponseData deniedByName` to nullable
- **Original**: The `deniedByName` field in `RecalculateCalculationOfStepResponseResponseData` was `not nullable`.
- **Updated**: The `deniedByName` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

237. Change `RecalculateCalculationOfStepResponseResponseData submittedByName` to nullable
- **Original**: The `submittedByName` field in `RecalculateCalculationOfStepResponseResponseData` was `not nullable`.
- **Updated**: The `submittedByName` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

238. Change `RecalculateCalculationOfStepResponseResponseData approvedByName` to nullable
- **Original**: The `approvedByName` field in `RecalculateCalculationOfStepResponseResponseData` was `not nullable`.
- **Updated**: The `approvedByName` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

239. Change `RecalculateCalculationOfStepResponseResponseData submittedBy` to nullable
- **Original**: The `submittedBy` field in `RecalculateCalculationOfStepResponseResponseData` was `not nullable`.
- **Updated**: The `submittedBy` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

240. Change `RecalculateCalculationOfStepResponseResponseData deniedBy` to nullable
- **Original**: The `deniedBy` field in `RecalculateCalculationOfStepResponseResponseData` was `not nullable`.
- **Updated**: The `deniedBy` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

241. Change `RecalculateCalculationOfStepResponseResponseData label` to nullable
- **Original**: The `label` field in `RecalculateCalculationOfStepResponseResponseData` was `not nullable`.
- **Updated**: The `label` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

242. Change `InlineResponse2003ResponseData serverMessagesExtended` to nullable
- **Original**: The `serverMessagesExtended` field in `InlineResponse2003ResponseData` was `not nullable`.
- **Updated**: The `serverMessagesExtended` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

243. Change `InlineResponse2003ResponseData externalRef` to nullable
- **Original**: The `externalRef` field in `InlineResponse2003ResponseData` was `not nullable`.
- **Updated**: The `externalRef` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

244. Change `InlineResponse2003ResponseData deniedByName` to nullable
- **Original**: The `deniedByName` field in `InlineResponse2003ResponseData` was `not nullable`.
- **Updated**: The `deniedByName` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

245. Change `InlineResponse2003ResponseData userGroupViewDetails` to nullable
- **Original**: The `userGroupViewDetails` field in `InlineResponse2003ResponseData` was `not nullable`.
- **Updated**: The `userGroupViewDetails` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

246. Change `InlineResponse2003ResponseData approvedByName` to nullable
- **Original**: The `approvedByName` field in `InlineResponse2003ResponseData` was `not nullable`.
- **Updated**: The `approvedByName` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

247. Change `InlineResponse2003ResponseData creationWorkflowCurrentStep` to nullable
- **Original**: The `creationWorkflowCurrentStep` field in `InlineResponse2003ResponseData` was `not nullable`.
- **Updated**: The `creationWorkflowCurrentStep` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

248. Change `InlineResponse2003ResponseData customerGroup` to nullable
- **Original**: The `customerGroup` field in `InlineResponse2003ResponseData` was `not nullable`.
- **Updated**: The `customerGroup` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

249. Change `InlineResponse2003ResponseData serverMessages` to nullable
- **Original**: The `serverMessages` field in `InlineResponse2003ResponseData` was `not nullable`.
- **Updated**: The `serverMessages` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

250. Change `InlineResponse2003ResponseData creationWorkflowInfo` to nullable
- **Original**: The `creationWorkflowInfo` field in `InlineResponse2003ResponseData` was `not nullable`.
- **Updated**: The `creationWorkflowInfo` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

251. Change `InlineResponse2003ResponseData creationWorkflowStatus` to nullable
- **Original**: The `creationWorkflowStatus` field in `InlineResponse2003ResponseData` was `not nullable`.
- **Updated**: The `creationWorkflowStatus` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

252. Change `InlineResponse2003ResponseData userGroupEdit` to nullable
- **Original**: The `userGroupEdit` field in `InlineResponse2003ResponseData` was `not nullable`.
- **Updated**: The `userGroupEdit` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

253. Change `InlineResponse2003ResponseData nodeId` to nullable
- **Original**: The `nodeId` field in `InlineResponse2003ResponseData` was `not nullable`.
- **Updated**: The `nodeId` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

254. Change `InlineResponse2003ResponseData renderInfo` to nullable
- **Original**: The `renderInfo` field in `InlineResponse2003ResponseData` was `not nullable`.
- **Updated**: The `renderInfo` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

255. Change `InlineResponse2003ResponseData lostReason` to nullable
- **Original**: The `lostReason` field in `InlineResponse2003ResponseData` was `not nullable`.
- **Updated**: The `lostReason` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

256. Change `InlineResponse2003ResponseData creationWorkflowStepCount` to nullable
- **Original**: The `creationWorkflowStepCount` field in `InlineResponse2003ResponseData` was `not nullable`.
- **Updated**: The `creationWorkflowStepCount` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

257. Change `InlineResponse2003ResponseData quoteType` to nullable
- **Original**: The `quoteType` field in `InlineResponse2003ResponseData` was `not nullable`.
- **Updated**: The `quoteType` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

258. Change `InlineResponse2003ResponseData lostReasonComment` to nullable
- **Original**: The `lostReasonComment` field in `InlineResponse2003ResponseData` was `not nullable`.
- **Updated**: The `lostReasonComment` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

259. Change `InlineResponse2003ResponseData creationWorkflowStepLabel` to nullable
- **Original**: The `creationWorkflowStepLabel` field in `InlineResponse2003ResponseData` was `not nullable`.
- **Updated**: The `creationWorkflowStepLabel` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

260. Change `InlineResponse2003ResponseData submittedByName` to nullable
- **Original**: The `submittedByName` field in `InlineResponse2003ResponseData` was `not nullable`.
- **Updated**: The `submittedByName` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

261. Change `InlineResponse2003ResponseData lastCalculationDate` to nullable
- **Original**: The `lastCalculationDate` field in `InlineResponse2003ResponseData` was `not nullable`.
- **Updated**: The `lastCalculationDate` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

262. Change `InlineResponse2003ResponseData additionalInfo4` to nullable
- **Original**: The `additionalInfo4` field in `InlineResponse2003ResponseData` was `not nullable`.
- **Updated**: The `additionalInfo4` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

263. Change `InlineResponse2003ResponseData additionalInfo3` to nullable
- **Original**: The `additionalInfo3` field in `InlineResponse2003ResponseData` was `not nullable`.
- **Updated**: The `additionalInfo3` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

264. Change `InlineResponse2003ResponseData additionalInfo2` to nullable
- **Original**: The `additionalInfo2` field in `InlineResponse2003ResponseData` was `not nullable`.
- **Updated**: The `additionalInfo2` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

265. Change `InlineResponse2003ResponseData additionalInfo1` to nullable
- **Original**: The `additionalInfo1` field in `InlineResponse2003ResponseData` was `not nullable`.
- **Updated**: The `additionalInfo1` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

266. Change `InlineResponse2003ResponseData reviewSubStepInfo` to nullable
- **Original**: The `reviewSubStepInfo` field in `InlineResponse2003ResponseData` was `not nullable`.
- **Updated**: The `reviewSubStepInfo` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

267. Change `InlineResponse2003ResponseData approvalRequiredEmailAttachmentsJson` to nullable
- **Original**: The `approvalRequiredEmailAttachmentsJson` field in `InlineResponse2003ResponseData` was `not nullable`.
- **Updated**: The `approvalRequiredEmailAttachmentsJson` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

268. Change `InlineResponse2003ResponseData prevRev` to nullable
- **Original**: The `prevRev` field in `InlineResponse2003ResponseData` was `not nullable`.
- **Updated**: The `prevRev` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

269. Change `InlineResponse2003ResponseData supersededBy` to nullable
- **Original**: The `supersededBy` field in `InlineResponse2003ResponseData` was `not nullable`.
- **Updated**: The `supersededBy` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

270. Change `InlineResponse2007ResponseData labelTranslations` to nullable
- **Original**: The `labelTranslations` field in `InlineResponse2007ResponseData` was `not nullable`.
- **Updated**: The `labelTranslations` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

271. Change `InlineResponse2007ResponseData cssProperties` to nullable
- **Original**: The `cssProperties` field in `InlineResponse2007ResponseData` was `not nullable`.
- **Updated**: The `cssProperties` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

272. Change `InlineResponse2007ResponseData overrideValueOptions` to nullable
- **Original**: The `overrideValueOptions` field in `InlineResponse2007ResponseData` was `not nullable`.
- **Updated**: The `overrideValueOptions` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

273. Change `InlineResponse2007ResponseData resultGroup` to nullable
- **Original**: The `resultGroup` field in `InlineResponse2007ResponseData` was `not nullable`.
- **Updated**: The `resultGroup` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

274. Change `InlineResponse2007ResponseData suffix` to nullable
- **Original**: The `suffix` field in `InlineResponse2007ResponseData` was `not nullable`.
- **Updated**: The `suffix` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

275. Change `InlineResponse2007ResponseData elementResult` to nullable
- **Original**: The `elementResult` field in `InlineResponse2007ResponseData` was `not nullable`.
- **Updated**: The `elementResult` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

276. Change `InlineResponse2007ResponseData elementResultDescription` to nullable
- **Original**: The `elementResultDescription` field in `InlineResponse2007ResponseData` was `not nullable`.
- **Updated**: The `elementResultDescription` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

277. Change `InlineResponse2007ResponseData formatType` to nullable
- **Original**: The `formatType` field in `InlineResponse2007ResponseData` was `not nullable`.
- **Updated**: The `formatType` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

278. Change `InlineResponse2007ResponseData userGroup` to nullable
- **Original**: The `userGroup` field in `InlineResponse2007ResponseData` was `not nullable`.
- **Updated**: The `userGroup` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

279. Change `InlineResponse2007ResponseData alertMessage` to nullable
- **Original**: The `alertMessage` field in `InlineResponse2007ResponseData` was `not nullable`.
- **Updated**: The `alertMessage` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

280. Change `InlineResponse2007ResponseData alertType` to nullable
- **Original**: The `alertType` field in `InlineResponse2007ResponseData` was `not nullable`.
- **Updated**: The `alertType` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

281. Change `InlineResponse2007ResponseData warnings` to nullable
- **Original**: The `warnings` field in `InlineResponse2007ResponseData` was `not nullable`.
- **Updated**: The `warnings` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

282. Change `InlineResponse2007ResponseData cellStyles` to nullable
- **Original**: The `cellStyles` field in `InlineResponse2007ResponseData` was `not nullable`.
- **Updated**: The `cellStyles` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

283. Change `InlineResponse2007ResponseData traceMessages` to nullable
- **Original**: The `traceMessages` field in `InlineResponse2007ResponseData` was `not nullable`.
- **Updated**: The `traceMessages` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

284. Change `InlineResponse2007ResponseData elementResultClass` to nullable
- **Original**: The `elementResultClass` field in `InlineResponse2007ResponseData` was `not nullable`.
- **Updated**: The `elementResultClass` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

285. Change `PreviewCustomFormWorkflowResponseResponseWorkflowSubSteps lastExecutedBy` to nullable
- **Original**: The `lastExecutedBy` field in `PreviewCustomFormWorkflowResponseResponseWorkflowSubSteps` was `not nullable`.
- **Updated**: The `lastExecutedBy` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

286. Change `PreviewCustomFormWorkflowResponseResponseWorkflowSubSteps comments` to nullable
- **Original**: The `comments` field in `PreviewCustomFormWorkflowResponseResponseWorkflowSubSteps` was `not nullable`.
- **Updated**: The `comments` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

287. Change `PreviewCustomFormWorkflowResponseResponseWorkflowSubSteps executionStatus` to nullable
- **Original**: The `executionStatus` field in `PreviewCustomFormWorkflowResponseResponseWorkflowSubSteps` was `not nullable`.
- **Updated**: The `executionStatus` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

288. Change `PreviewCustomFormWorkflowResponseResponseWorkflowSubSteps comment` to nullable
- **Original**: The `comment` field in `PreviewCustomFormWorkflowResponseResponseWorkflowSubSteps` was `not nullable`.
- **Updated**: The `comment` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

289. Change `PreviewCustomFormWorkflowResponseResponseWorkflowSubSteps lastExecutionDate` to nullable
- **Original**: The `lastExecutionDate` field in `PreviewCustomFormWorkflowResponseResponseWorkflowSubSteps` was `not nullable`.
- **Updated**: The `lastExecutionDate` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

290. Change `ListSellersRequest oldValues` to nullable
- **Original**: The `oldValues` field in `ListSellersRequest` was `not nullable`.
- **Updated**: The `oldValues` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

291. Change `DataChangeRequestMassChangeMassChange type` to nullable
- **Original**: The `type` field in `DataChangeRequestMassChangeMassChange` was `not nullable`.
- **Updated**: The `type` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

292. Change `DMDataLoadPre80CalculationConfig targetDate` to nullable
- **Original**: The `targetDate` field in `DMDataLoadPre80CalculationConfig` was `not nullable`.
- **Updated**: The `targetDate` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

293. Change `PreviewCustomFormWorkflowResponseResponseWorkflowSteps userGroupNames` to nullable
- **Original**: The `userGroupNames` field in `PreviewCustomFormWorkflowResponseResponseWorkflowSteps` was `not nullable`.
- **Updated**: The `userGroupNames` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

294. Change `PreviewCustomFormWorkflowResponseResponseWorkflowSteps minApprovalsForGroups` to nullable
- **Original**: The `minApprovalsForGroups` field in `PreviewCustomFormWorkflowResponseResponseWorkflowSteps` was `not nullable`.
- **Updated**: The `minApprovalsForGroups` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

295. Change `PreviewCustomFormWorkflowResponseResponseWorkflowSteps isPostStepLogicFailed` to nullable
- **Original**: The `isPostStepLogicFailed` field in `PreviewCustomFormWorkflowResponseResponseWorkflowSteps` was `not nullable`.
- **Updated**: The `isPostStepLogicFailed` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

296. Change `PreviewCustomFormWorkflowResponseResponseWorkflowSteps userGroupTypedId` to nullable
- **Original**: The `userGroupTypedId` field in `PreviewCustomFormWorkflowResponseResponseWorkflowSteps` was `not nullable`.
- **Updated**: The `userGroupTypedId` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

297. Change `PreviewCustomFormWorkflowResponseResponseWorkflowSteps userGroupTypedIds` to nullable
- **Original**: The `userGroupTypedIds` field in `PreviewCustomFormWorkflowResponseResponseWorkflowSteps` was `not nullable`.
- **Updated**: The `userGroupTypedIds` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

298. Change `PreviewCustomFormWorkflowResponseResponseWorkflowSteps userGroupName` to nullable
- **Original**: The `userGroupName` field in `PreviewCustomFormWorkflowResponseResponseWorkflowSteps` was `not nullable`.
- **Updated**: The `userGroupName` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

299. Change `PreviewCustomFormWorkflowResponseResponseWorkflowSteps comment` to nullable
- **Original**: The `comment` field in `PreviewCustomFormWorkflowResponseResponseWorkflowSteps` was `not nullable`.
- **Updated**: The `comment` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

300. Change `PreviewCustomFormWorkflowResponseResponseWorkflowSteps mandatoryComments` to nullable
- **Original**: The `mandatoryComments` field in `PreviewCustomFormWorkflowResponseResponseWorkflowSteps` was `not nullable`.
- **Updated**: The `mandatoryComments` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

301. Change `SX3Inner attribute1` to nullable
- **Original**: The `attribute1` field in `SX3Inner` was `not nullable`.
- **Updated**: The `attribute1` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

302. Change `SX3Inner attribute3` to nullable
- **Original**: The `attribute3` field in `SX3Inner` was `not nullable`.
- **Updated**: The `attribute3` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

303. Change `SX3Inner attribute2` to nullable
- **Original**: The `attribute2` field in `SX3Inner` was `not nullable`.
- **Updated**: The `attribute2` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

304. Change `InlineResponse201ResponseErrorsMessage errorMessage` to nullable
- **Original**: The `errorMessage` field in `InlineResponse201ResponseErrorsMessage` was `not nullable`.
- **Updated**: The `errorMessage` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

305. Change `InlineResponse20037ResponseItem formulaName` to nullable
- **Original**: The `formulaName` field in `InlineResponse20037ResponseItem` was `not nullable`.
- **Updated**: The `formulaName` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

306. Change `InlineResponse20037ResponseItem attribute19` to nullable
- **Original**: The `attribute19` field in `InlineResponse20037ResponseItem` was `not nullable`.
- **Updated**: The `attribute19` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

307. Change `InlineResponse20037ResponseItem attribute18` to nullable
- **Original**: The `attribute18` field in `InlineResponse20037ResponseItem` was `not nullable`.
- **Updated**: The `attribute18` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

308. Change `InlineResponse20037ResponseItem attribute17` to nullable
- **Original**: The `attribute17` field in `InlineResponse20037ResponseItem` was `not nullable`.
- **Updated**: The `attribute17` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

309. Change `InlineResponse20037ResponseItem attribute16` to nullable
- **Original**: The `attribute16` field in `InlineResponse20037ResponseItem` was `not nullable`.
- **Updated**: The `attribute16` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

310. Change `InlineResponse20037ResponseItem attribute15` to nullable
- **Original**: The `attribute15` field in `InlineResponse20037ResponseItem` was `not nullable`.
- **Updated**: The `attribute15` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

311. Change `InlineResponse20037ResponseItem attribute25` to nullable
- **Original**: The `attribute25` field in `InlineResponse20037ResponseItem` was `not nullable`.
- **Updated**: The `attribute25` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

312. Change `InlineResponse20037ResponseItem attribute24` to nullable
- **Original**: The `attribute24` field in `InlineResponse20037ResponseItem` was `not nullable`.
- **Updated**: The `attribute24` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

313. Change `InlineResponse20037ResponseItem userGroupViewDetails` to nullable
- **Original**: The `userGroupViewDetails` field in `InlineResponse20037ResponseItem` was `not nullable`.
- **Updated**: The `userGroupViewDetails` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

314. Change `InlineResponse20037ResponseItem attribute23` to nullable
- **Original**: The `attribute23` field in `InlineResponse20037ResponseItem` was `not nullable`.
- **Updated**: The `attribute23` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

315. Change `InlineResponse20037ResponseItem attribute22` to nullable
- **Original**: The `attribute22` field in `InlineResponse20037ResponseItem` was `not nullable`.
- **Updated**: The `attribute22` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

316. Change `InlineResponse20037ResponseItem attribute21` to nullable
- **Original**: The `attribute21` field in `InlineResponse20037ResponseItem` was `not nullable`.
- **Updated**: The `attribute21` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

317. Change `InlineResponse20037ResponseItem attribute20` to nullable
- **Original**: The `attribute20` field in `InlineResponse20037ResponseItem` was `not nullable`.
- **Updated**: The `attribute20` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

318. Change `InlineResponse20037ResponseItem image` to nullable
- **Original**: The `image` field in `InlineResponse20037ResponseItem` was `not nullable`.
- **Updated**: The `image` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

319. Change `InlineResponse20037ResponseItem unitOfMeasure` to nullable
- **Original**: The `unitOfMeasure` field in `InlineResponse20037ResponseItem` was `not nullable`.
- **Updated**: The `unitOfMeasure` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

320. Change `InlineResponse20037ResponseItem attribute29` to nullable
- **Original**: The `attribute29` field in `InlineResponse20037ResponseItem` was `not nullable`.
- **Updated**: The `attribute29` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

321. Change `InlineResponse20037ResponseItem attribute28` to nullable
- **Original**: The `attribute28` field in `InlineResponse20037ResponseItem` was `not nullable`.
- **Updated**: The `attribute28` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

322. Change `InlineResponse20037ResponseItem attribute27` to nullable
- **Original**: The `attribute27` field in `InlineResponse20037ResponseItem` was `not nullable`.
- **Updated**: The `attribute27` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

323. Change `InlineResponse20037ResponseItem attribute26` to nullable
- **Original**: The `attribute26` field in `InlineResponse20037ResponseItem` was `not nullable`.
- **Updated**: The `attribute26` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

324. Change `InlineResponse20037ResponseItem attribute9` to nullable
- **Original**: The `attribute9` field in `InlineResponse20037ResponseItem` was `not nullable`.
- **Updated**: The `attribute9` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

325. Change `InlineResponse20037ResponseItem attribute8` to nullable
- **Original**: The `attribute8` field in `InlineResponse20037ResponseItem` was `not nullable`.
- **Updated**: The `attribute8` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

326. Change `InlineResponse20037ResponseItem attribute4` to nullable
- **Original**: The `attribute4` field in `InlineResponse20037ResponseItem` was `not nullable`.
- **Updated**: The `attribute4` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

327. Change `InlineResponse20037ResponseItem attribute7` to nullable
- **Original**: The `attribute7` field in `InlineResponse20037ResponseItem` was `not nullable`.
- **Updated**: The `attribute7` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

328. Change `InlineResponse20037ResponseItem attribute6` to nullable
- **Original**: The `attribute6` field in `InlineResponse20037ResponseItem` was `not nullable`.
- **Updated**: The `attribute6` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

329. Change `InlineResponse20037ResponseItem attribute1` to nullable
- **Original**: The `attribute1` field in `InlineResponse20037ResponseItem` was `not nullable`.
- **Updated**: The `attribute1` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

330. Change `InlineResponse20037ResponseItem attribute14` to nullable
- **Original**: The `attribute14` field in `InlineResponse20037ResponseItem` was `not nullable`.
- **Updated**: The `attribute14` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

331. Change `InlineResponse20037ResponseItem attribute13` to nullable
- **Original**: The `attribute13` field in `InlineResponse20037ResponseItem` was `not nullable`.
- **Updated**: The `attribute13` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

332. Change `InlineResponse20037ResponseItem userGroupEdit` to nullable
- **Original**: The `userGroupEdit` field in `InlineResponse20037ResponseItem` was `not nullable`.
- **Updated**: The `userGroupEdit` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

333. Change `InlineResponse20037ResponseItem attribute3` to nullable
- **Original**: The `attribute3` field in `InlineResponse20037ResponseItem` was `not nullable`.
- **Updated**: The `attribute3` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

334. Change `InlineResponse20037ResponseItem attribute12` to nullable
- **Original**: The `attribute12` field in `InlineResponse20037ResponseItem` was `not nullable`.
- **Updated**: The `attribute12` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

335. Change `InlineResponse20037ResponseItem attribute2` to nullable
- **Original**: The `attribute2` field in `InlineResponse20037ResponseItem` was `not nullable`.
- **Updated**: The `attribute2` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

336. Change `InlineResponse20037ResponseItem attribute11` to nullable
- **Original**: The `attribute11` field in `InlineResponse20037ResponseItem` was `not nullable`.
- **Updated**: The `attribute11` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

337. Change `InlineResponse20037ResponseItem attribute10` to nullable
- **Original**: The `attribute10` field in `InlineResponse20037ResponseItem` was `not nullable`.
- **Updated**: The `attribute10` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

338. Change `InlineResponse20037ResponseItem attribute30` to nullable
- **Original**: The `attribute30` field in `InlineResponse20037ResponseItem` was `not nullable`.
- **Updated**: The `attribute30` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

339. Change `JobStatusTrackerJobSettingsDistributedAction queueName` to nullable
- **Original**: The `queueName` field in `JobStatusTrackerJobSettingsDistributedAction` was `not nullable`.
- **Updated**: The `queueName` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

340. Change `JobStatusTrackerJobSettingsDistributedAction partitionName` to nullable
- **Original**: The `partitionName` field in `JobStatusTrackerJobSettingsDistributedAction` was `not nullable`.
- **Updated**: The `partitionName` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

341. Change `JobStatusTrackerJobSettingsDistributedAction enableDirtyTracking` to nullable
- **Original**: The `enableDirtyTracking` field in `JobStatusTrackerJobSettingsDistributedAction` was `not nullable`.
- **Updated**: The `enableDirtyTracking` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

342. Change `JobStatusTrackerJobSettingsDistributedAction runNumber` to nullable
- **Original**: The `runNumber` field in `JobStatusTrackerJobSettingsDistributedAction` was `not nullable`.
- **Updated**: The `runNumber` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

343. Change `CompensationRecordSetCalculationCompensationRecordSet calculationMessages` to nullable
- **Original**: The `calculationMessages` field in `CompensationRecordSetCalculationCompensationRecordSet` was `not nullable`.
- **Updated**: The `calculationMessages` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

344. Change `CompensationRecordSetCalculationCompensationRecordSet targetDate` to nullable
- **Original**: The `targetDate` field in `CompensationRecordSetCalculationCompensationRecordSet` was `not nullable`.
- **Updated**: The `targetDate` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

345. Change `CompensationRecordSetCalculationCompensationRecordSet locale` to nullable
- **Original**: The `locale` field in `CompensationRecordSetCalculationCompensationRecordSet` was `not nullable`.
- **Updated**: The `locale` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

346. Change `CompensationRecordSetCalculationCompensationRecordSet calculationDate` to nullable
- **Original**: The `calculationDate` field in `CompensationRecordSetCalculationCompensationRecordSet` was `not nullable`.
- **Updated**: The `calculationDate` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

347. Change `CompensationRecordSetCalculationCompensationRecordSet userGroupEdit` to nullable
- **Original**: The `userGroupEdit` field in `CompensationRecordSetCalculationCompensationRecordSet` was `not nullable`.
- **Updated**: The `userGroupEdit` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

348. Change `CompensationRecordSetCalculationCompensationRecordSet userGroupViewDetails` to nullable
- **Original**: The `userGroupViewDetails` field in `CompensationRecordSetCalculationCompensationRecordSet` was `not nullable`.
- **Updated**: The `userGroupViewDetails` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

349. Change `CompensationRecordSetCalculationCompensationRecordSet calculationStartDate` to nullable
- **Original**: The `calculationStartDate` field in `CompensationRecordSetCalculationCompensationRecordSet` was `not nullable`.
- **Updated**: The `calculationStartDate` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

350. Change `CustomFormOutputs alertMessage` to nullable
- **Original**: The `alertMessage` field in `CustomFormOutputs` was `not nullable`.
- **Updated**: The `alertMessage` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

351. Change `CustomFormOutputs cssProperties` to nullable
- **Original**: The `cssProperties` field in `CustomFormOutputs` was `not nullable`.
- **Updated**: The `cssProperties` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

352. Change `CustomFormOutputs labelTranslations` to nullable
- **Original**: The `labelTranslations` field in `CustomFormOutputs` was `not nullable`.
- **Updated**: The `labelTranslations` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

353. Change `CustomFormOutputs alertType` to nullable
- **Original**: The `alertType` field in `CustomFormOutputs` was `not nullable`.
- **Updated**: The `alertType` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

354. Change `CustomFormOutputs overrideValueOptions` to nullable
- **Original**: The `overrideValueOptions` field in `CustomFormOutputs` was `not nullable`.
- **Updated**: The `overrideValueOptions` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

355. Change `CustomFormOutputs warnings` to nullable
- **Original**: The `warnings` field in `CustomFormOutputs` was `not nullable`.
- **Updated**: The `warnings` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

356. Change `CustomFormOutputs resultGroup` to nullable
- **Original**: The `resultGroup` field in `CustomFormOutputs` was `not nullable`.
- **Updated**: The `resultGroup` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

357. Change `CustomFormOutputs suffix` to nullable
- **Original**: The `suffix` field in `CustomFormOutputs` was `not nullable`.
- **Updated**: The `suffix` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

358. Change `CustomFormOutputs displayOptions` to nullable
- **Original**: The `displayOptions` field in `CustomFormOutputs` was `not nullable`.
- **Updated**: The `displayOptions` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

359. Change `CustomFormOutputs result` to nullable
- **Original**: The `result` field in `CustomFormOutputs` was `not nullable`.
- **Updated**: The `result` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

360. Change `CustomFormOutputs resultDescription` to nullable
- **Original**: The `resultDescription` field in `CustomFormOutputs` was `not nullable`.
- **Updated**: The `resultDescription` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

361. Change `CustomFormOutputs resultType` to nullable
- **Original**: The `resultType` field in `CustomFormOutputs` was `not nullable`.
- **Updated**: The `resultType` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

362. Change `CustomFormOutputs userGroup` to nullable
- **Original**: The `userGroup` field in `CustomFormOutputs` was `not nullable`.
- **Updated**: The `userGroup` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

363. Change `ClicmanageradditemstypedIdDataInputs value` to nullable
- **Original**: The `value` field in `ClicmanageradditemstypedIdDataInputs` was `not nullable`.
- **Updated**: The `value` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

364. Change `ImportManagerImportOptions includeNewRows` to nullable
- **Original**: The `includeNewRows` field in `ImportManagerImportOptions` was `not nullable`.
- **Updated**: The `includeNewRows` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

365. Change `ImportManagerImportOptions includeDeletedRows` to nullable
- **Original**: The `includeDeletedRows` field in `ImportManagerImportOptions` was `not nullable`.
- **Updated**: The `includeDeletedRows` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

366. Change `ImportManagerImportOptions includeUpdatedRows` to nullable
- **Original**: The `includeUpdatedRows` field in `ImportManagerImportOptions` was `not nullable`.
- **Updated**: The `includeUpdatedRows` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

367. Change `SX20Inner attribute19` to nullable
- **Original**: The `attribute19` field in `SX20Inner` was `not nullable`.
- **Updated**: The `attribute19` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

368. Change `SX20Inner attribute18` to nullable
- **Original**: The `attribute18` field in `SX20Inner` was `not nullable`.
- **Updated**: The `attribute18` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

369. Change `SX20Inner attribute17` to nullable
- **Original**: The `attribute17` field in `SX20Inner` was `not nullable`.
- **Updated**: The `attribute17` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

370. Change `SX20Inner attribute16` to nullable
- **Original**: The `attribute16` field in `SX20Inner` was `not nullable`.
- **Updated**: The `attribute16` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

371. Change `SX20Inner attribute15` to nullable
- **Original**: The `attribute15` field in `SX20Inner` was `not nullable`.
- **Updated**: The `attribute15` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

372. Change `SX20Inner attribute20` to nullable
- **Original**: The `attribute20` field in `SX20Inner` was `not nullable`.
- **Updated**: The `attribute20` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

373. Change `SX20Inner attribute9` to nullable
- **Original**: The `attribute9` field in `SX20Inner` was `not nullable`.
- **Updated**: The `attribute9` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

374. Change `SX20Inner attribute8` to nullable
- **Original**: The `attribute8` field in `SX20Inner` was `not nullable`.
- **Updated**: The `attribute8` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

375. Change `SX20Inner attribute5` to nullable
- **Original**: The `attribute5` field in `SX20Inner` was `not nullable`.
- **Updated**: The `attribute5` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

376. Change `SX20Inner attribute4` to nullable
- **Original**: The `attribute4` field in `SX20Inner` was `not nullable`.
- **Updated**: The `attribute4` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

377. Change `SX20Inner attribute7` to nullable
- **Original**: The `attribute7` field in `SX20Inner` was `not nullable`.
- **Updated**: The `attribute7` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

378. Change `SX20Inner attribute6` to nullable
- **Original**: The `attribute6` field in `SX20Inner` was `not nullable`.
- **Updated**: The `attribute6` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

379. Change `SX20Inner attribute1` to nullable
- **Original**: The `attribute1` field in `SX20Inner` was `not nullable`.
- **Updated**: The `attribute1` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

380. Change `SX20Inner attribute14` to nullable
- **Original**: The `attribute14` field in `SX20Inner` was `not nullable`.
- **Updated**: The `attribute14` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

381. Change `SX20Inner attribute13` to nullable
- **Original**: The `attribute13` field in `SX20Inner` was `not nullable`.
- **Updated**: The `attribute13` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

382. Change `SX20Inner attribute3` to nullable
- **Original**: The `attribute3` field in `SX20Inner` was `not nullable`.
- **Updated**: The `attribute3` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

383. Change `SX20Inner attribute12` to nullable
- **Original**: The `attribute12` field in `SX20Inner` was `not nullable`.
- **Updated**: The `attribute12` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

384. Change `SX20Inner attribute2` to nullable
- **Original**: The `attribute2` field in `SX20Inner` was `not nullable`.
- **Updated**: The `attribute2` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

385. Change `SX20Inner attribute11` to nullable
- **Original**: The `attribute11` field in `SX20Inner` was `not nullable`.
- **Updated**: The `attribute11` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

386. Change `SX20Inner attribute10` to nullable
- **Original**: The `attribute10` field in `SX20Inner` was `not nullable`.
- **Updated**: The `attribute10` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

387. Change `TruncateKVTableResponseResponse data` to nullable
- **Original**: The `data` field in `TruncateKVTableResponseResponse` was `not nullable`.
- **Updated**: The `data` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

388. Change `InlineResponse20082ResponseData originalValue` to nullable
- **Original**: The `originalValue` field in `InlineResponse20082ResponseData` was `not nullable`.
- **Updated**: The `originalValue` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

389. Change `InlineResponse20082ResponseData validationErrors` to nullable
- **Original**: The `validationErrors` field in `InlineResponse20082ResponseData` was `not nullable`.
- **Updated**: The `validationErrors` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

390. Change `InlineResponse20082ResponseData value` to nullable
- **Original**: The `value` field in `InlineResponse20082ResponseData` was `not nullable`.
- **Updated**: The `value` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

391. Change `InlineResponse20082ResponseData columnName` to nullable
- **Original**: The `columnName` field in `InlineResponse20082ResponseData` was `not nullable`.
- **Updated**: The `columnName` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

392. Change `QuoteTmpInputs labelTranslations` to nullable
- **Original**: The `labelTranslations` field in `QuoteTmpInputs` was `not nullable`.
- **Updated**: The `labelTranslations` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

393. Change `QuoteTmpInputs addUnknownValues` to nullable
- **Original**: The `addUnknownValues` field in `QuoteTmpInputs` was `not nullable`.
- **Updated**: The `addUnknownValues` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

394. Change `QuoteTmpInputs typedId` to nullable
- **Original**: The `typedId` field in `QuoteTmpInputs` was `not nullable`.
- **Updated**: The `typedId` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

395. Change `QuoteTmpInputs readOnly` to nullable
- **Original**: The `readOnly` field in `QuoteTmpInputs` was `not nullable`.
- **Updated**: The `readOnly` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

396. Change `QuoteTmpInputs parameterGroup` to nullable
- **Original**: The `parameterGroup` field in `QuoteTmpInputs` was `not nullable`.
- **Updated**: The `parameterGroup` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

397. Change `QuoteTmpInputs url` to nullable
- **Original**: The `url` field in `QuoteTmpInputs` was `not nullable`.
- **Updated**: The `url` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

398. Change `QuoteTmpInputs valueHint` to nullable
- **Original**: The `valueHint` field in `QuoteTmpInputs` was `not nullable`.
- **Updated**: The `valueHint` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

399. Change `QuoteTmpInputs required` to nullable
- **Original**: The `required` field in `QuoteTmpInputs` was `not nullable`.
- **Updated**: The `required` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

400. Change `QuoteTmpInputs alwaysEditable` to nullable
- **Original**: The `alwaysEditable` field in `QuoteTmpInputs` was `not nullable`.
- **Updated**: The `alwaysEditable` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

401. Change `QuoteTmpInputs valueOptions` to nullable
- **Original**: The `valueOptions` field in `QuoteTmpInputs` was `not nullable`.
- **Updated**: The `valueOptions` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

402. Change `QuoteTmpInputs filter` to nullable
- **Original**: The `filter` field in `QuoteTmpInputs` was `not nullable`.
- **Updated**: The `filter` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

403. Change `QuoteTmpInputs lookupTableId` to nullable
- **Original**: The `lookupTableId` field in `QuoteTmpInputs` was `not nullable`.
- **Updated**: The `lookupTableId` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

404. Change `QuoteTmpInputs value` to nullable
- **Original**: The `value` field in `QuoteTmpInputs` was `not nullable`.
- **Updated**: The `value` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

405. Change `ListCalculationsRequest oldValues` to nullable
- **Original**: The `oldValues` field in `ListCalculationsRequest` was `not nullable`.
- **Updated**: The `oldValues` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

406. Change `CustomFormInputs labelTranslations` to nullable
- **Original**: The `labelTranslations` field in `CustomFormInputs` was `not nullable`.
- **Updated**: The `labelTranslations` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

407. Change `CustomFormInputs addUnknownValues` to nullable
- **Original**: The `addUnknownValues` field in `CustomFormInputs` was `not nullable`.
- **Updated**: The `addUnknownValues` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

408. Change `CustomFormInputs typedId` to nullable
- **Original**: The `typedId` field in `CustomFormInputs` was `not nullable`.
- **Updated**: The `typedId` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

409. Change `CustomFormInputs readOnly` to nullable
- **Original**: The `readOnly` field in `CustomFormInputs` was `not nullable`.
- **Updated**: The `readOnly` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

410. Change `CustomFormInputs label` to nullable
- **Original**: The `label` field in `CustomFormInputs` was `not nullable`.
- **Updated**: The `label` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

411. Change `CustomFormInputs parameterGroup` to nullable
- **Original**: The `parameterGroup` field in `CustomFormInputs` was `not nullable`.
- **Updated**: The `parameterGroup` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

412. Change `CustomFormInputs url` to nullable
- **Original**: The `url` field in `CustomFormInputs` was `not nullable`.
- **Updated**: The `url` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

413. Change `CustomFormInputs valueHint` to nullable
- **Original**: The `valueHint` field in `CustomFormInputs` was `not nullable`.
- **Updated**: The `valueHint` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

414. Change `CustomFormInputs required` to nullable
- **Original**: The `required` field in `CustomFormInputs` was `not nullable`.
- **Updated**: The `required` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

415. Change `CustomFormInputs alwaysEditable` to nullable
- **Original**: The `alwaysEditable` field in `CustomFormInputs` was `not nullable`.
- **Updated**: The `alwaysEditable` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

416. Change `CustomFormInputs valueOptions` to nullable
- **Original**: The `valueOptions` field in `CustomFormInputs` was `not nullable`.
- **Updated**: The `valueOptions` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

417. Change `CustomFormInputs lookupTableId` to nullable
- **Original**: The `lookupTableId` field in `CustomFormInputs` was `not nullable`.
- **Updated**: The `lookupTableId` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

418. Change `CustomFormInputs value` to nullable
- **Original**: The `value` field in `CustomFormInputs` was `not nullable`.
- **Updated**: The `value` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

419. Change `ListParallelCalculationItemsRequest oldValues` to nullable
- **Original**: The `oldValues` field in `ListParallelCalculationItemsRequest` was `not nullable`.
- **Updated**: The `oldValues` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

420. Change `NotificationListBody oldValues` to nullable
- **Original**: The `oldValues` field in `NotificationListBody` was `not nullable`.
- **Updated**: The `oldValues` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

421. Change `SaveCalculationRequest oldValues` to nullable
- **Original**: The `oldValues` field in `SaveCalculationRequest` was `not nullable`.
- **Updated**: The `oldValues` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

422. Change `UpdatePOldValues userGroupViewDetails` to nullable
- **Original**: The `userGroupViewDetails` field in `UpdatePOldValues` was `not nullable`.
- **Updated**: The `userGroupViewDetails` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

423. Change `UpdatePOldValues userGroupEdit` to nullable
- **Original**: The `userGroupEdit` field in `UpdatePOldValues` was `not nullable`.
- **Updated**: The `userGroupEdit` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

424. Change `SX50Inner attribute39` to nullable
- **Original**: The `attribute39` field in `SX50Inner` was `not nullable`.
- **Updated**: The `attribute39` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

425. Change `SX50Inner attribute38` to nullable
- **Original**: The `attribute38` field in `SX50Inner` was `not nullable`.
- **Updated**: The `attribute38` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

426. Change `SX50Inner attribute37` to nullable
- **Original**: The `attribute37` field in `SX50Inner` was `not nullable`.
- **Updated**: The `attribute37` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

427. Change `SX50Inner attribute47` to nullable
- **Original**: The `attribute47` field in `SX50Inner` was `not nullable`.
- **Updated**: The `attribute47` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

428. Change `SX50Inner attribute46` to nullable
- **Original**: The `attribute46` field in `SX50Inner` was `not nullable`.
- **Updated**: The `attribute46` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

429. Change `SX50Inner attribute45` to nullable
- **Original**: The `attribute45` field in `SX50Inner` was `not nullable`.
- **Updated**: The `attribute45` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

430. Change `SX50Inner attribute44` to nullable
- **Original**: The `attribute44` field in `SX50Inner` was `not nullable`.
- **Updated**: The `attribute44` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

431. Change `SX50Inner attribute43` to nullable
- **Original**: The `attribute43` field in `SX50Inner` was `not nullable`.
- **Updated**: The `attribute43` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

432. Change `SX50Inner attribute42` to nullable
- **Original**: The `attribute42` field in `SX50Inner` was `not nullable`.
- **Updated**: The `attribute42` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

433. Change `SX50Inner attribute41` to nullable
- **Original**: The `attribute41` field in `SX50Inner` was `not nullable`.
- **Updated**: The `attribute41` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

434. Change `SX50Inner attribute40` to nullable
- **Original**: The `attribute40` field in `SX50Inner` was `not nullable`.
- **Updated**: The `attribute40` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

435. Change `SX50Inner attribute49` to nullable
- **Original**: The `attribute49` field in `SX50Inner` was `not nullable`.
- **Updated**: The `attribute49` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

436. Change `SX50Inner attribute48` to nullable
- **Original**: The `attribute48` field in `SX50Inner` was `not nullable`.
- **Updated**: The `attribute48` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

437. Change `SX50Inner attribute9` to nullable
- **Original**: The `attribute9` field in `SX50Inner` was `not nullable`.
- **Updated**: The `attribute9` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

438. Change `SX50Inner attribute50` to nullable
- **Original**: The `attribute50` field in `SX50Inner` was `not nullable`.
- **Updated**: The `attribute50` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

439. Change `SX50Inner attribute8` to nullable
- **Original**: The `attribute8` field in `SX50Inner` was `not nullable`.
- **Updated**: The `attribute8` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

440. Change `SX50Inner attribute5` to nullable
- **Original**: The `attribute5` field in `SX50Inner` was `not nullable`.
- **Updated**: The `attribute5` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

441. Change `SX50Inner attribute4` to nullable
- **Original**: The `attribute4` field in `SX50Inner` was `not nullable`.
- **Updated**: The `attribute4` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

442. Change `SX50Inner attribute7` to nullable
- **Original**: The `attribute7` field in `SX50Inner` was `not nullable`.
- **Updated**: The `attribute7` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

443. Change `SX50Inner attribute6` to nullable
- **Original**: The `attribute6` field in `SX50Inner` was `not nullable`.
- **Updated**: The `attribute6` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

444. Change `SX50Inner attribute1` to nullable
- **Original**: The `attribute1` field in `SX50Inner` was `not nullable`.
- **Updated**: The `attribute1` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

445. Change `SX50Inner attribute14` to nullable
- **Original**: The `attribute14` field in `SX50Inner` was `not nullable`.
- **Updated**: The `attribute14` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

446. Change `SX50Inner attribute13` to nullable
- **Original**: The `attribute13` field in `SX50Inner` was `not nullable`.
- **Updated**: The `attribute13` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

447. Change `SX50Inner attribute3` to nullable
- **Original**: The `attribute3` field in `SX50Inner` was `not nullable`.
- **Updated**: The `attribute3` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

448. Change `SX50Inner attribute12` to nullable
- **Original**: The `attribute12` field in `SX50Inner` was `not nullable`.
- **Updated**: The `attribute12` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

449. Change `SX50Inner attribute2` to nullable
- **Original**: The `attribute2` field in `SX50Inner` was `not nullable`.
- **Updated**: The `attribute2` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

450. Change `SX50Inner attribute11` to nullable
- **Original**: The `attribute11` field in `SX50Inner` was `not nullable`.
- **Updated**: The `attribute11` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

451. Change `SX50Inner attribute10` to nullable
- **Original**: The `attribute10` field in `SX50Inner` was `not nullable`.
- **Updated**: The `attribute10` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

452. Change `SX50Inner attribute19` to nullable
- **Original**: The `attribute19` field in `SX50Inner` was `not nullable`.
- **Updated**: The `attribute19` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

453. Change `SX50Inner attribute18` to nullable
- **Original**: The `attribute18` field in `SX50Inner` was `not nullable`.
- **Updated**: The `attribute18` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

454. Change `SX50Inner attribute17` to nullable
- **Original**: The `attribute17` field in `SX50Inner` was `not nullable`.
- **Updated**: The `attribute17` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

455. Change `SX50Inner attribute16` to nullable
- **Original**: The `attribute16` field in `SX50Inner` was `not nullable`.
- **Updated**: The `attribute16` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

456. Change `SX50Inner attribute15` to nullable
- **Original**: The `attribute15` field in `SX50Inner` was `not nullable`.
- **Updated**: The `attribute15` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

457. Change `SX50Inner attribute25` to nullable
- **Original**: The `attribute25` field in `SX50Inner` was `not nullable`.
- **Updated**: The `attribute25` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

458. Change `SX50Inner attribute24` to nullable
- **Original**: The `attribute24` field in `SX50Inner` was `not nullable`.
- **Updated**: The `attribute24` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

459. Change `SX50Inner attribute23` to nullable
- **Original**: The `attribute23` field in `SX50Inner` was `not nullable`.
- **Updated**: The `attribute23` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

460. Change `SX50Inner attribute22` to nullable
- **Original**: The `attribute22` field in `SX50Inner` was `not nullable`.
- **Updated**: The `attribute22` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

461. Change `SX50Inner attribute21` to nullable
- **Original**: The `attribute21` field in `SX50Inner` was `not nullable`.
- **Updated**: The `attribute21` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

462. Change `SX50Inner attribute20` to nullable
- **Original**: The `attribute20` field in `SX50Inner` was `not nullable`.
- **Updated**: The `attribute20` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

463. Change `SX50Inner attribute29` to nullable
- **Original**: The `attribute29` field in `SX50Inner` was `not nullable`.
- **Updated**: The `attribute29` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

464. Change `SX50Inner attribute28` to nullable
- **Original**: The `attribute28` field in `SX50Inner` was `not nullable`.
- **Updated**: The `attribute28` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

465. Change `SX50Inner attribute27` to nullable
- **Original**: The `attribute27` field in `SX50Inner` was `not nullable`.
- **Updated**: The `attribute27` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

466. Change `SX50Inner attribute26` to nullable
- **Original**: The `attribute26` field in `SX50Inner` was `not nullable`.
- **Updated**: The `attribute26` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

467. Change `SX50Inner attribute36` to nullable
- **Original**: The `attribute36` field in `SX50Inner` was `not nullable`.
- **Updated**: The `attribute36` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

468. Change `SX50Inner attribute35` to nullable
- **Original**: The `attribute35` field in `SX50Inner` was `not nullable`.
- **Updated**: The `attribute35` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

469. Change `SX50Inner attribute34` to nullable
- **Original**: The `attribute34` field in `SX50Inner` was `not nullable`.
- **Updated**: The `attribute34` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

470. Change `SX50Inner attribute33` to nullable
- **Original**: The `attribute33` field in `SX50Inner` was `not nullable`.
- **Updated**: The `attribute33` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

471. Change `SX50Inner attribute32` to nullable
- **Original**: The `attribute32` field in `SX50Inner` was `not nullable`.
- **Updated**: The `attribute32` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

472. Change `SX50Inner attribute31` to nullable
- **Original**: The `attribute31` field in `SX50Inner` was `not nullable`.
- **Updated**: The `attribute31` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

473. Change `SX50Inner attribute30` to nullable
- **Original**: The `attribute30` field in `SX50Inner` was `not nullable`.
- **Updated**: The `attribute30` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

474. Change `CustomFormCustomFormTypeObject typedId` to nullable
- **Original**: The `typedId` field in `CustomFormCustomFormTypeObject` was `not nullable`.
- **Updated**: The `typedId` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

475. Change `CustomFormCustomFormTypeObject moduleCategoryUN` to nullable
- **Original**: The `moduleCategoryUN` field in `CustomFormCustomFormTypeObject` was `not nullable`.
- **Updated**: The `moduleCategoryUN` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

476. Change `CustomFormCustomFormTypeObject userGroupEdit` to nullable
- **Original**: The `userGroupEdit` field in `CustomFormCustomFormTypeObject` was `not nullable`.
- **Updated**: The `userGroupEdit` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

477. Change `InlineResponse201Response data` to nullable
- **Original**: The `data` field in `InlineResponse201Response` was `not nullable`.
- **Updated**: The `data` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

478. Change `SX8Inner attribute8` to nullable
- **Original**: The `attribute8` field in `SX8Inner` was `not nullable`.
- **Updated**: The `attribute8` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

479. Change `SX8Inner attribute5` to nullable
- **Original**: The `attribute5` field in `SX8Inner` was `not nullable`.
- **Updated**: The `attribute5` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

480. Change `SX8Inner attribute4` to nullable
- **Original**: The `attribute4` field in `SX8Inner` was `not nullable`.
- **Updated**: The `attribute4` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

481. Change `SX8Inner attribute7` to nullable
- **Original**: The `attribute7` field in `SX8Inner` was `not nullable`.
- **Updated**: The `attribute7` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

482. Change `SX8Inner attribute6` to nullable
- **Original**: The `attribute6` field in `SX8Inner` was `not nullable`.
- **Updated**: The `attribute6` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

483. Change `SX8Inner attribute1` to nullable
- **Original**: The `attribute1` field in `SX8Inner` was `not nullable`.
- **Updated**: The `attribute1` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

484. Change `SX8Inner attribute3` to nullable
- **Original**: The `attribute3` field in `SX8Inner` was `not nullable`.
- **Updated**: The `attribute3` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

485. Change `SX8Inner attribute2` to nullable
- **Original**: The `attribute2` field in `SX8Inner` was `not nullable`.
- **Updated**: The `attribute2` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

486. Change `PreviewCustomFormWorkflowResponseResponseWorkflow submitReason` to nullable
- **Original**: The `submitReason` field in `PreviewCustomFormWorkflowResponseResponseWorkflow` was `not nullable`.
- **Updated**: The `submitReason` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

487. Change `PreviewCustomFormWorkflowResponseResponseWorkflow submitterUserName` to nullable
- **Original**: The `submitterUserName` field in `PreviewCustomFormWorkflowResponseResponseWorkflow` was `not nullable`.
- **Updated**: The `submitterUserName` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

488. Change `PreviewCustomFormWorkflowResponseResponseWorkflow submitterTypedId` to nullable
- **Original**: The `submitterTypedId` field in `PreviewCustomFormWorkflowResponseResponseWorkflow` was `not nullable`.
- **Updated**: The `submitterTypedId` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

489. Change `ListCalculationGridItemsRequest oldValues` to nullable
- **Original**: The `oldValues` field in `ListCalculationGridItemsRequest` was `not nullable`.
- **Updated**: The `oldValues` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

490. Change `PreviewCustomFormWorkflowResponseResponseData layout` to nullable
- **Original**: The `layout` field in `PreviewCustomFormWorkflowResponseResponseData` was `not nullable`.
- **Updated**: The `layout` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

491. Change `ListConditionTypesRequest oldValues` to nullable
- **Original**: The `oldValues` field in `ListConditionTypesRequest` was `not nullable`.
- **Updated**: The `oldValues` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

492. Change `CompensationInputs labelTranslations` to nullable
- **Original**: The `labelTranslations` field in `CompensationInputs` was `not nullable`.
- **Updated**: The `labelTranslations` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

493. Change `CompensationInputs addUnknownValues` to nullable
- **Original**: The `addUnknownValues` field in `CompensationInputs` was `not nullable`.
- **Updated**: The `addUnknownValues` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

494. Change `CompensationInputs typedId` to nullable
- **Original**: The `typedId` field in `CompensationInputs` was `not nullable`.
- **Updated**: The `typedId` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

495. Change `CompensationInputs readOnly` to nullable
- **Original**: The `readOnly` field in `CompensationInputs` was `not nullable`.
- **Updated**: The `readOnly` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

496. Change `CompensationInputs parameterGroup` to nullable
- **Original**: The `parameterGroup` field in `CompensationInputs` was `not nullable`.
- **Updated**: The `parameterGroup` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

497. Change `CompensationInputs url` to nullable
- **Original**: The `url` field in `CompensationInputs` was `not nullable`.
- **Updated**: The `url` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

498. Change `CompensationInputs valueHint` to nullable
- **Original**: The `valueHint` field in `CompensationInputs` was `not nullable`.
- **Updated**: The `valueHint` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

499. Change `CompensationInputs required` to nullable
- **Original**: The `required` field in `CompensationInputs` was `not nullable`.
- **Updated**: The `required` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

500. Change `CompensationInputs alwaysEditable` to nullable
- **Original**: The `alwaysEditable` field in `CompensationInputs` was `not nullable`.
- **Updated**: The `alwaysEditable` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

501. Change `CompensationInputs valueOptions` to nullable
- **Original**: The `valueOptions` field in `CompensationInputs` was `not nullable`.
- **Updated**: The `valueOptions` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

502. Change `CompensationInputs filter` to nullable
- **Original**: The `filter` field in `CompensationInputs` was `not nullable`.
- **Updated**: The `filter` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

503. Change `CompensationInputs lookupTableId` to nullable
- **Original**: The `lookupTableId` field in `CompensationInputs` was `not nullable`.
- **Updated**: The `lookupTableId` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

504. Change `CompensationInputs value` to nullable
- **Original**: The `value` field in `CompensationInputs` was `not nullable`.
- **Updated**: The `value` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

505. Change `InlineResponse20050ResponseLocaleData overriddenValue` to nullable
- **Original**: The `overriddenValue` field in `InlineResponse20050ResponseLocaleData` was `not nullable`.
- **Updated**: The `overriddenValue` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

506. Change `CompensationLineItems endDate` to nullable
- **Original**: The `endDate` field in `CompensationLineItems` was `not nullable`.
- **Updated**: The `endDate` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

507. Change `CompensationLineItems payoutDate` to nullable
- **Original**: The `payoutDate` field in `CompensationLineItems` was `not nullable`.
- **Updated**: The `payoutDate` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

508. Change `CompensationLineItems startDate` to nullable
- **Original**: The `startDate` field in `CompensationLineItems` was `not nullable`.
- **Updated**: The `startDate` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

509. Change `DataChangeRequestMassChangeMassChangeDefinitions changeStateReason` to nullable
- **Original**: The `changeStateReason` field in `DataChangeRequestMassChangeMassChangeDefinitions` was `not nullable`.
- **Updated**: The `changeStateReason` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

510. Change `DataChangeRequestMassChangeMassChangeDefinitions precision` to nullable
- **Original**: The `precision` field in `DataChangeRequestMassChangeMassChangeDefinitions` was `not nullable`.
- **Updated**: The `precision` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

511. Change `RecalculateCalculationOfStepResponseResponseJobs processingStart` to nullable
- **Original**: The `processingStart` field in `RecalculateCalculationOfStepResponseResponseJobs` was `not nullable`.
- **Updated**: The `processingStart` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

512. Change `RecalculateCalculationOfStepResponseResponseJobs threadId` to nullable
- **Original**: The `threadId` field in `RecalculateCalculationOfStepResponseResponseJobs` was `not nullable`.
- **Updated**: The `threadId` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

513. Change `RecalculateCalculationOfStepResponseResponseJobs threadUUID` to nullable
- **Original**: The `threadUUID` field in `RecalculateCalculationOfStepResponseResponseJobs` was `not nullable`.
- **Updated**: The `threadUUID` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

514. Change `RecalculateCalculationOfStepResponseResponseJobs calculationResults` to nullable
- **Original**: The `calculationResults` field in `RecalculateCalculationOfStepResponseResponseJobs` was `not nullable`.
- **Updated**: The `calculationResults` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

515. Change `RecalculateCalculationOfStepResponseResponseJobs processingNode` to nullable
- **Original**: The `processingNode` field in `RecalculateCalculationOfStepResponseResponseJobs` was `not nullable`.
- **Updated**: The `processingNode` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

516. Change `RecalculateCalculationOfStepResponseResponseJobs processingEnd` to nullable
- **Original**: The `processingEnd` field in `RecalculateCalculationOfStepResponseResponseJobs` was `not nullable`.
- **Updated**: The `processingEnd` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

517. Change `RecalculateCalculationOfStepResponseResponseJobs progress` to nullable
- **Original**: The `progress` field in `RecalculateCalculationOfStepResponseResponseJobs` was `not nullable`.
- **Updated**: The `progress` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

518. Change `RecalculateCalculationOfStepResponseResponseJobs messages` to nullable
- **Original**: The `messages` field in `RecalculateCalculationOfStepResponseResponseJobs` was `not nullable`.
- **Updated**: The `messages` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

519. Change `RecalculateCalculationOfStepResponseResponseJobs parameters` to nullable
- **Original**: The `parameters` field in `RecalculateCalculationOfStepResponseResponseJobs` was `not nullable`.
- **Updated**: The `parameters` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

520. Change `AddCRCIMData fieldValueOptions` to nullable
- **Original**: The `fieldValueOptions` field in `AddCRCIMData` was `not nullable`.
- **Updated**: The `fieldValueOptions` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

521. Change `AddCRCIMData entityRefTypeCode` to nullable
- **Original**: The `entityRefTypeCode` field in `AddCRCIMData` was `not nullable`.
- **Updated**: The `entityRefTypeCode` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

522. Change `InlineResponse20084Response data` to nullable
- **Original**: The `data` field in `InlineResponse20084Response` was `not nullable`.
- **Updated**: The `data` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

523. Change `InlineResponse20036ResponseData sender` to nullable
- **Original**: The `sender` field in `InlineResponse20036ResponseData` was `not nullable`.
- **Updated**: The `sender` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

524. Change `InlineResponse20036ResponseData recipients` to nullable
- **Original**: The `recipients` field in `InlineResponse20036ResponseData` was `not nullable`.
- **Updated**: The `recipients` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

525. Change `InlineResponse20036ResponseData userGroupEdit` to nullable
- **Original**: The `userGroupEdit` field in `InlineResponse20036ResponseData` was `not nullable`.
- **Updated**: The `userGroupEdit` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

526. Change `InlineResponse20036ResponseData userGroupViewDetails` to nullable
- **Original**: The `userGroupViewDetails` field in `InlineResponse20036ResponseData` was `not nullable`.
- **Updated**: The `userGroupViewDetails` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

527. Change `InlineResponse20036ResponseData embeddedOwner` to nullable
- **Original**: The `embeddedOwner` field in `InlineResponse20036ResponseData` was `not nullable`.
- **Updated**: The `embeddedOwner` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

528. Change `UpdateSXOldValues attribute1` to nullable
- **Original**: The `attribute1` field in `UpdateSXOldValues` was `not nullable`.
- **Updated**: The `attribute1` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

529. Change `UpdateSXOldValues attribute3` to nullable
- **Original**: The `attribute3` field in `UpdateSXOldValues` was `not nullable`.
- **Updated**: The `attribute3` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

530. Change `UpdateSXOldValues attribute2` to nullable
- **Original**: The `attribute2` field in `UpdateSXOldValues` was `not nullable`.
- **Updated**: The `attribute2` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

531. Change `RecalculateCalculationOfStepResponseResponseJobSettings distributedAction` to nullable
- **Original**: The `distributedAction` field in `RecalculateCalculationOfStepResponseResponseJobSettings` was `not nullable`.
- **Updated**: The `distributedAction` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

532. Change `UpdateTypeCodereturnolddataOldValues userGroupViewDetails` to nullable
- **Original**: The `userGroupViewDetails` field in `UpdateTypeCodereturnolddataOldValues` was `not nullable`.
- **Updated**: The `userGroupViewDetails` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

533. Change `UpdateTypeCodereturnolddataOldValues userGroupEdit` to nullable
- **Original**: The `userGroupEdit` field in `UpdateTypeCodereturnolddataOldValues` was `not nullable`.
- **Updated**: The `userGroupEdit` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

534. Change `CompensationServerMessagesExtended key` to nullable
- **Original**: The `key` field in `CompensationServerMessagesExtended` was `not nullable`.
- **Updated**: The `key` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

535. Change `InlineResponse2003ResponseInputs labelTranslations` to nullable
- **Original**: The `labelTranslations` field in `InlineResponse2003ResponseInputs` was `not nullable`.
- **Updated**: The `labelTranslations` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

536. Change `InlineResponse2003ResponseInputs addUnknownValues` to nullable
- **Original**: The `addUnknownValues` field in `InlineResponse2003ResponseInputs` was `not nullable`.
- **Updated**: The `addUnknownValues` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

537. Change `InlineResponse2003ResponseInputs typedId` to nullable
- **Original**: The `typedId` field in `InlineResponse2003ResponseInputs` was `not nullable`.
- **Updated**: The `typedId` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

538. Change `InlineResponse2003ResponseInputs readOnly` to nullable
- **Original**: The `readOnly` field in `InlineResponse2003ResponseInputs` was `not nullable`.
- **Updated**: The `readOnly` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

539. Change `InlineResponse2003ResponseInputs parameterGroup` to nullable
- **Original**: The `parameterGroup` field in `InlineResponse2003ResponseInputs` was `not nullable`.
- **Updated**: The `parameterGroup` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

540. Change `InlineResponse2003ResponseInputs required` to nullable
- **Original**: The `required` field in `InlineResponse2003ResponseInputs` was `not nullable`.
- **Updated**: The `required` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

541. Change `InlineResponse2003ResponseInputs alwaysEditable` to nullable
- **Original**: The `alwaysEditable` field in `InlineResponse2003ResponseInputs` was `not nullable`.
- **Updated**: The `alwaysEditable` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

542. Change `InlineResponse2003ResponseInputs valueOptions` to nullable
- **Original**: The `valueOptions` field in `InlineResponse2003ResponseInputs` was `not nullable`.
- **Updated**: The `valueOptions` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

543. Change `InlineResponse2003ResponseInputs filter` to nullable
- **Original**: The `filter` field in `InlineResponse2003ResponseInputs` was `not nullable`.
- **Updated**: The `filter` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

544. Change `InlineResponse2003ResponseInputs lookupTableId` to nullable
- **Original**: The `lookupTableId` field in `InlineResponse2003ResponseInputs` was `not nullable`.
- **Updated**: The `lookupTableId` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

545. Change `InlineResponse2003ResponseInputs userGroupView` to nullable
- **Original**: The `userGroupView` field in `InlineResponse2003ResponseInputs` was `not nullable`.
- **Updated**: The `userGroupView` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

546. Change `InlineResponse2003ResponseInputs userGroupEdit` to nullable
- **Original**: The `userGroupEdit` field in `InlineResponse2003ResponseInputs` was `not nullable`.
- **Updated**: The `userGroupEdit` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

547. Change `JobStatusTrackerJobSettings queueName` to nullable
- **Original**: The `queueName` field in `JobStatusTrackerJobSettings` was `not nullable`.
- **Updated**: The `queueName` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

548. Change `UpsertKVKeyResponseResponse data` to nullable
- **Original**: The `data` field in `UpsertKVKeyResponseResponse` was `not nullable`.
- **Updated**: The `data` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

549. Change `InlineResponse20045ResponseWorkflowSubSteps lastExecutedBy` to nullable
- **Original**: The `lastExecutedBy` field in `InlineResponse20045ResponseWorkflowSubSteps` was `not nullable`.
- **Updated**: The `lastExecutedBy` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

550. Change `InlineResponse20045ResponseWorkflowSubSteps comments` to nullable
- **Original**: The `comments` field in `InlineResponse20045ResponseWorkflowSubSteps` was `not nullable`.
- **Updated**: The `comments` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

551. Change `InlineResponse20045ResponseWorkflowSubSteps executionStatus` to nullable
- **Original**: The `executionStatus` field in `InlineResponse20045ResponseWorkflowSubSteps` was `not nullable`.
- **Updated**: The `executionStatus` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

552. Change `InlineResponse20045ResponseWorkflowSubSteps comment` to nullable
- **Original**: The `comment` field in `InlineResponse20045ResponseWorkflowSubSteps` was `not nullable`.
- **Updated**: The `comment` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

553. Change `InlineResponse20045ResponseWorkflowSubSteps lastExecutionDate` to nullable
- **Original**: The `lastExecutionDate` field in `InlineResponse20045ResponseWorkflowSubSteps` was `not nullable`.
- **Updated**: The `lastExecutionDate` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

554. Change `InlineResponse20040Response data` to nullable
- **Original**: The `data` field in `InlineResponse20040Response` was `not nullable`.
- **Updated**: The `data` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

555. Change `RecalculateCalculationOfStepResponseResponseStateTwoTabsTab2 StringEntry` to nullable
- **Original**: The `StringEntry` field in `RecalculateCalculationOfStepResponseResponseStateTwoTabsTab2` was `not nullable`.
- **Updated**: The `StringEntry` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

556. Change `InlineResponse2008ResponseJobs processingStart` to nullable
- **Original**: The `processingStart` field in `InlineResponse2008ResponseJobs` was `not nullable`.
- **Updated**: The `processingStart` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

557. Change `InlineResponse2008ResponseJobs threadId` to nullable
- **Original**: The `threadId` field in `InlineResponse2008ResponseJobs` was `not nullable`.
- **Updated**: The `threadId` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

558. Change `InlineResponse2008ResponseJobs threadUUID` to nullable
- **Original**: The `threadUUID` field in `InlineResponse2008ResponseJobs` was `not nullable`.
- **Updated**: The `threadUUID` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

559. Change `InlineResponse2008ResponseJobs calculationResults` to nullable
- **Original**: The `calculationResults` field in `InlineResponse2008ResponseJobs` was `not nullable`.
- **Updated**: The `calculationResults` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

560. Change `InlineResponse2008ResponseJobs processingNode` to nullable
- **Original**: The `processingNode` field in `InlineResponse2008ResponseJobs` was `not nullable`.
- **Updated**: The `processingNode` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

561. Change `InlineResponse2008ResponseJobs processingEnd` to nullable
- **Original**: The `processingEnd` field in `InlineResponse2008ResponseJobs` was `not nullable`.
- **Updated**: The `processingEnd` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

562. Change `InlineResponse2008ResponseJobs progress` to nullable
- **Original**: The `progress` field in `InlineResponse2008ResponseJobs` was `not nullable`.
- **Updated**: The `progress` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

563. Change `InlineResponse2008ResponseJobs messages` to nullable
- **Original**: The `messages` field in `InlineResponse2008ResponseJobs` was `not nullable`.
- **Updated**: The `messages` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

564. Add missing `items` to array schemas
- **Original**: Four schemas declared a field as `"type": "array"` with no `items` sub-schema, which is invalid per the OpenAPI/JSON Schema spec — `CompensationRecordSetCalculation.dtoFilter.additionalProperties.anyOf[2]`, `AddPGTTDataTypeConfigurationCalculationLogicInputs.value.oneOf[2]`, `UpdateCFOTData.supportedParentTypeCodes.anyOf[0]`, and `QuoteLineItemOutputs.overrideValueOptions`.
- **Updated**: Added an `items` sub-schema to each — `{}` (accepts any value) for the first two and the last, since they are untyped/polymorphic value containers; `{"type": "string"}` for `supportedParentTypeCodes`, matching its sibling `anyOf` branch which is `type: string`.
- **Reason**: `bal openapi` rejects the spec outright without this — a genuine defect in the upstream Pricefx spec, not a flatten/align artifact.

565. Remove empty `requestBody` from `POST /uploadmanager.progress/{uploadslot}`
- **Original**: The operation declared `"requestBody": {}` — a `requestBody` object with no `content`, which is invalid.
- **Updated**: Removed the empty `requestBody` entirely; the operation takes no request body (only the `uploadslot` path parameter).
- **Reason**: `bal openapi` rejects the spec outright without this — a genuine defect in the upstream Pricefx spec, not a flatten/align artifact.

566. Remove invalid `requestBody` from GET operations
- **Original**: `GET /login/extended` (`login`) and `GET /configurationmanager.getexternalappproperties` each declared a `requestBody` with an empty schema (`{"type": "object", "properties": {}}`) — GET operations cannot have a request body.
- **Updated**: Removed `requestBody` from both operations.
- **Reason**: `bal openapi` rejects the spec outright without this — a genuine defect in the upstream Pricefx spec, not a flatten/align artifact.

## Post-generation architecture: pristine generated submodule + hand-written wrapper

Generated with `--client-methods remote` (see the `bal openapi` command below) directly into the
`ballerina/modules/oas` submodule, which is never hand-edited — following the same
generated/wrapper split as
[`module-ballerinax-googleapis.gmail`](https://github.com/ballerina-platform/module-ballerinax-googleapis.gmail):

- `ballerina/modules/oas/{client.bal,types.bal,utils.bal}` is the **unmodified** `bal openapi`
  output (aside from the two codegen-bug fixes in entry 569, which are compile-blocking and have
  nothing to do with auth). The class is `public isolated client class Client`, referenced from
  outside the submodule as `oas:Client`. This means regenerating the submodule is always safe:
  `bal openapi -i docs/spec/openapi.json -o ballerina/modules/oas --client-methods remote --mode
  client --license docs/license.txt` can be rerun at any time without reconciling hand-written
  changes into generated files.
- `ballerina/modules/oas` must be listed in the root `Ballerina.toml`'s `export` array
  (`export = ["pricefx", "pricefx.oas"]`). The wrapper's public remote functions return and accept
  `oas:X` types directly (no request/response type conversion layer, unlike gmail's
  `convertOASXToX()` functions — impractical to hand-write and maintain for 480 operations), so
  submodule types are part of the wrapper's public API surface and must be externally resolvable.
- The root `ballerina/client.bal` is entirely hand-written and holds all customization:
  - `public isolated client class Client` has a **non-`final`** `oas:Client oasClient` field
    (guarded by `lock` via `getOasClient()`/direct assignment), because the generated client's own
    fields are `final` — refreshing auth means constructing a whole new `oas:Client` instance and
    swapping it in, not mutating the existing one.
  - `init()` and `reauthenticate()` both call a private `createOasClient()` helper that builds a
    fresh `oas:Client`: if `auth.pricefxKey` is set, it exchanges credentials for a JWT via
    `fetchAccessToken()` (see below) and constructs `oas:ApiKeysConfig{xPriceFxJwt: <token>}`;
    otherwise it authenticates every request via HTTP Basic auth, using
    `${partition}/${username}` as the Basic auth username (Pricefx requires the partition-prefixed
    form — a bare username is rejected).
  - Every one of the 480 operations is a thin forwarding `remote` function: read the current
    `oas:Client` via `getOasClient()`, call the operation, check `isAuthError(r)` (HTTP 401), and
    if so call `self.reauthenticate()` and retry once against the freshly-rebuilt client.
    `isAuthError` is a small helper at the bottom of `client.bal`.
  - `fetchAccessToken()` makes its **own** raw `http:Client` call to `POST /token` rather than
    going through the generated `oas:Client.createAuthToken()` operation. That generated operation
    has a real bug (see below) that can no longer be hand-patched now that generated code is
    off-limits, so the wrapper's bootstrap flow bypasses it entirely.
  - `self.config` (the wrapper's own `ConnectionConfig`, readonly-cloned in `init()`) is stored so
    `reauthenticate()` can rebuild an equivalent `oas:Client` later. `ConnectionConfig` deliberately
    **omits** `cookieConfig` (present in the generated `oas:ConnectionConfig`): its optional
    `PersistentCookieHandler` field is a mutable `isolated object`, which is not `Cloneable`, so a
    `ConnectionConfig` that includes it can never be `.cloneReadOnly()`'d — and this connector
    doesn't rely on cookie-based session handling anyway (auth is handled explicitly via JWT or
    Basic auth, never cookies).
- `ballerina/types.bal` (root) is entirely hand-written and holds only wrapper-specific types:
  `PricefxCredentials` (`username`, `password`, `partition`, `pricefxKey?`) and `ConnectionConfig`
  (mirrors the generated `oas:ConnectionConfig`'s HTTP transport settings field-for-field, minus
  `cookieConfig`). `ConnectionConfig` includes `PricefxCredentials` via `*PricefxCredentials;`
  rather than nesting it under an `auth` field (unlike the generated
  `http:CredentialsConfig|oas:ApiKeysConfig` union), so callers construct a `Client` as
  `check new ({username, password, partition}, serviceUrl)` — credentials are top-level fields,
  not a separate `auth` record — and never handle a JWT themselves.

A known, deliberately-unfixed limitation: the generated client's `createAuthToken`,
`refreshAuthToken`, and `deleteAuthToken` operations remain reachable through the wrapper (as
`pricefxClient->createAuthToken(...)`, etc. — every generated operation is forwarded, including
these), but calling them **directly** still hits a genuine `bal openapi` codegen bug: their header
parameter types (`CreateAuthTokenHeaders`, etc.) carry a `pricefxKey` field annotated
`@http:Header {name: "Pricefx-Key"}`, but the generated function body builds the outgoing headers
via a plain `map<anydata> headerValues = {...headers};` spread, which uses the record's Ballerina
field name (`pricefxKey`) as the header key, not the annotation's real wire name
(`Pricefx-Key`) — so the request is always sent with the wrong header name and Pricefx rejects it
with `400 no header value found for 'Pricefx-Key'`. This can no longer be hand-patched (generated
code is off-limits), so it is left as-is; callers who need this exchange should rely on the
wrapper's own automatic JWT bootstrap (set `pricefxKey` in `PricefxCredentials`) rather than
calling `createAuthToken` directly. There is no test for `createAuthToken` for this reason.

If new operations are added to the spec, regenerate the submodule (safe, no reconciliation
needed), then regenerate the wrapper's forwarding functions mechanically from the submodule's
remote function signatures (name, parameters, return type) rather than editing `client.bal` by
hand — `init()`, `getOasClient()`, `reauthenticate()`, `createOasClient()`, `fetchAccessToken()`,
and `isAuthError()` are the only parts of `client.bal` that require actual hand-authorship.

**A `bal` 2201.12.0 parser gotcha found while writing `ConnectionConfig`**: a doc comment (`#
...`) placed directly above a `*Type;` record-type-inclusion member breaks the parser outright —
it emits nonsensical errors (`missing object keyword`, `'X' is not an object`, `field
initialization not allowed in object type`, `invalid token '?'`) for every field that follows,
as if it had switched into parsing an `object` type. Reproduced with a minimal two-file package
(a closed record including another closed record via `*Creds;`, with a multi-line doc comment
directly above the `*Creds;` line) — removing the doc comment (or moving it up to document the
including type itself, as done here for `ConnectionConfig`) fixes it. Keep this in mind for any
future record that uses type inclusion — document the included type's role on the *record's own*
doc comment, never directly above the `*Type;` line itself.

567. Expand coverage from 11 core tags to the full spec (480 operations)
- **Original**: The first version of this connector was generated with `--tags` restricted to 11 core resource areas (Products, Customers, Sellers, Condition Records, Price Lists, Manual Price Lists, Calculation Grids, Quotes, Contracts, Attachments, Authentication) — 139 of the spec's 484 operations.
- **Updated**: Removed the `--tags` filter entirely; the client now covers all remaining operations across the other 43 tags (Sales Compensations, Data Manager, Rebates, Optimization, Workflow, User Admin, Live Price Grids, Custom Forms, Comments, Notifications, etc.), plus the 139 core operationIds and 29 core schema renames from the prior pass, and the same treatment applied to the remaining 345 operationIds and 66 generic `InlineResponseNNN` schemas.
- **Reason**: Full API coverage requested.

568. Remove 4 generic catch-all operations that collide with specific Calculation Grid Item endpoints
- **Original**: The spec defines both generic single-typeCode catch-all operations (`POST /add/{typeCode}` → `createObject`, `POST /delete/{typeCode}` → `deleteObject`, `POST /fetch/{typeCode}` → `listObjects`, `POST /fetch/{typeCode}/{id}` → `getObject`) and specific Calculation Grid Item endpoints with a single templated segment (`POST /add/CGI{keyNumber}`, `POST /delete/CGI{keyNumber}`, `POST /fetch/CGI{keyNumber}`, `POST /fetch/CGI{keyNumber}/{id}`). Both pairs template to the identical Ballerina resource path shape (a single path parameter segment), which `bal openapi`/Ballerina's resource-method dispatch cannot disambiguate — client generation failed with `redeclared symbol` errors.
- **Updated**: Removed the 4 generic catch-all operations (`createObject`, `deleteObject`, `listObjects`, `getObject`) from the spec. All other type codes already have dedicated, specifically-named, more strongly-typed endpoints generated elsewhere in the client (e.g. `addProduct`, `addCustomer`, `addSeller`, etc.), so no unique functionality is lost except for arbitrary/future type codes that have no dedicated endpoint.
- **Reason**: A genuine Ballerina resource-routing limitation — two distinct URL shapes that happen to template identically cannot coexist as separate resource methods on the same client class.

569. Fix two malformed generated identifiers from special-character field names
- **Original**: A field literally named `Margin %` in the JSON schema was generated as the Ballerina identifier `margin%` (an invalid identifier — `%` is not a valid character in an unescaped Ballerina identifier). Separately, a field literally named `""` (empty string) generated the annotation `@jsondata:Name {value: """"}`, which is not valid Ballerina string-literal syntax.
- **Updated**: Renamed the Ballerina identifier to `marginPercent` (the `@jsondata:Name {value: "Margin %"}` annotation already preserves the real wire name). Fixed the second annotation to `@jsondata:Name {value: ""}`.
- **Reason**: `bal build` fails outright without these — both are `bal openapi` codegen escaping bugs when a JSON field name contains characters that aren't valid in an unescaped Ballerina identifier or that need escaping inside a string literal.

570. Rename an operationId that started with a digit
- **Original**: `POST /productimages.upload/{slotId}/{sku}` was auto-assigned the operationId `2UploadFile` (derived mechanically from its summary, "2. Upload a File" — a numbered-step summary, not a parenthetical qualifier). A leading digit is not a valid Ballerina identifier character.
- **Updated**: Renamed to `uploadProductImage`.
- **Reason**: With `--client-methods remote` (see below), the operationId becomes the literal generated function name. `bal openapi` escapes invalid identifiers with a leading quote (`'2UploadFile`), which compiles but is non-idiomatic and awkward to call. This went unnoticed with resource methods, since resource functions are named from the HTTP method and path rather than the operationId.

571. Escape a field named after a Ballerina reserved word
- **Original**: `InlineResponse2008ResponseStateDefinitionSource.source` (wire name `Source`) was generated as the plain identifier `source`. `source` is a contextual reserved keyword in Ballerina (used in annotation-attachment-point syntax), so the compiler rejects it as an unescaped field name ("invalid token 'source'").
- **Updated**: Escaped to `'source` in `types.bal` (the `@jsondata:Name {value: "Source"}` annotation already preserves the real wire name).
- **Reason**: `bal build` fails outright without this — another `bal openapi` codegen gap (unlike most reserved-word field names elsewhere in this spec, which the tool already escapes correctly). Confirmed non-deterministic across regenerations of the identical spec: one regeneration produced this already correctly escaped (no fix needed that time), the very next regeneration (after adding the `oauth2` security scheme in entry 572) reproduced the original bug again. Always check for it after any regeneration rather than assuming either outcome.

572. Add an `oauth2` security scheme for the Authorization Code Grant flow
- **Original**: The spec already documented the `/oauth/authorize` and `/oauth/token` operations (standard OAuth 2.0 Authorization Code Grant, RFC 6749) as plain operations, but declared no `oauth2`-type security scheme, so `bal openapi` never generated any OAuth2-aware auth configuration - `ConnectionConfig.auth` only ever offered `http:CredentialsConfig` (Basic) and `ApiKeysConfig` (the `X-PriceFx-jwt` header).
- **Updated**: Added an `oauth2` security scheme (`type: oauth2`, `flows.authorizationCode` with `authorizationUrl: /oauth/authorize`, `tokenUrl: /oauth/token`) and `{"oauth2": []}` to the global `security` array.
- **Reason**: Requested support for every auth method Pricefx's API documents, maximizing what's generated rather than hand-written. This one change alone makes `bal openapi` generate `oas:OAuth2RefreshTokenGrantConfig` (an inclusion of `http:OAuth2RefreshTokenGrantConfig`) as an additional `ConnectionConfig.auth` union member. Ballerina's `http`/`oauth2` modules have no client-side concept of the Authorization Code Grant itself (no library can automate obtaining the initial `code` - that inherently needs an interactive browser redirect), but they do fully support the **refresh token** grant: given a refresh token (obtained once, out-of-band, through the real Authorization Code Grant flow), the `http` module automatically fetches and refreshes access tokens and attaches `Authorization: Bearer <token>` to every request. That's the piece that actually needs to run unattended in a server-to-server connector, and it's now 100% generated - see `ballerina/client.bal`'s `createOasClient` for how the wrapper plugs a caller-supplied `oauth2ClientId`/`oauth2ClientSecret`/`oauth2RefreshToken` into it.
- **Side effects discovered while adding this** (both confirmed via a from-scratch regeneration):
  - The `ballerina/http` version resolved for the submodule changed (unrelated to this specific change - just not pinned), which changed several `ConnectionConfig` HTTP-transport fields' shapes: `followRedirects` and `socketConfig` disappeared, `http1Settings` became a locally-generated `oas:ClientHttp1Settings` (embeds a local `ProxyConfig`) instead of `http:ClientHttp1Settings`, several fields lost their `= {}` defaults (now plain `?`), and `timeout`'s default changed from `30` to `60`. The wrapper's own `ConnectionConfig` (`ballerina/types.bal`) and `createOasClient`'s field-by-field mapping had to be updated to match. **Always diff the actual generated `ConnectionConfig` after any regeneration** rather than assuming its shape is stable - it depends on which `http` version gets resolved, not just on the spec.
  - With the `oauth2` scheme added, `bal openapi` stopped respecting the `X-PriceFx-jwt` security scheme's `x-ballerina-name: xPriceFxJwt` annotation - `ApiKeysConfig`'s field is now the raw escaped identifier `X\-PriceFx\-jwt` instead of the clean `xPriceFxJwt`. Everywhere the wrapper builds an `ApiKeysConfig` value, it now has to use the escaped field name.

573. Support TFA, CSRF, and External JWT as static per-request headers
- **Context**: Pricefx also documents two-factor auth (`PriceFx-TFA` header), CSRF protection (`X-PriceFx-Csrf-Token` header), and External JWT auth (a pre-signed JWT from a trusted external system, sent as `Authorization: BEARER <systemName>;<jwt>`). None of these can be generated: TFA and CSRF aren't auth *methods* at all (they're supplementary headers layered onto whatever primary auth is used), and adding them as `apiKey` security schemes was tried and rejected - `bal openapi` merges every `apiKey` scheme into a single `ApiKeysConfig` record with **all** fields required together, which would wrongly force a TFA code and CSRF token onto every JWT-only caller. External JWT's `BEARER <system>;<jwt>` value doesn't match any standard security scheme shape either.
- **Solution**: `PricefxCredentials` gained `tfaCode?`, `csrfToken?`, `externalJwtSystemName?`, and `externalJwt?` fields (see `ballerina/types.bal`). `ballerina/client.bal`'s `buildStaticHeaders` turns whichever of these are set into a header map, and every one of the 480 forwarding functions merges it into that call's headers via a shared `mergeHeaders` helper (a mapping constructor can't spread two inclusive/open map types at once - `{...a, ...b}` - so the merge is a small loop instead). The three token-management operations (`createAuthToken`/`refreshAuthToken`/`deleteAuthToken`) are skipped, since their `headers` parameter is a specific record type, not the generic `map<string|string[]>` the merge needs.
- **External JWT's underlying "base" auth is deliberately `ApiKeysConfig`, never `CredentialsConfig`**: `ConnectionConfig.auth` is a required field, so External-JWT-only callers (no username/password) still need *some* value there. The obvious-looking fix - a placeholder `http:CredentialsConfig` with dummy values - is wrong for two reasons, both confirmed via a real failing test before this was caught: (1) Ballerina's own `ClientBasicAuthHandler` rejects empty username/password outright ("Username or password cannot be empty"), and (2) even with non-empty placeholders, that handler's `enrich()` *unconditionally* overwrites any `Authorization` header via `req.setHeader(...)` - it does not check whether the request already carries one - which would silently clobber the real external JWT on every single request. `ApiKeysConfig` (with an empty `X\-PriceFx\-jwt` value) sidesteps this entirely: the generated `oas:Client.init()` only wires `httpClientConfig.auth` for the `http:CredentialsConfig` case, so choosing `ApiKeysConfig` means no client-level auth enrichment ever runs, and the wrapper's manually-merged `Authorization` header reaches the server untouched.

## OpenAPI cli command

The following command was used to generate the Ballerina client from the OpenAPI specification. The command should be executed from the repository root directory.

```bash
bal openapi -i docs/spec/openapi.json -o ballerina/modules/oas --mode client --client-methods remote --license docs/license.txt
```

This command generates directly into the `oas` submodule and never touches the hand-written
`ballerina/client.bal` or `ballerina/types.bal`. After regenerating, reapply the two codegen-bug
fixes from entry 569 (check whether the `'source` reserved-keyword escaping from entry 571 is
still needed — it was already correctly escaped by the tool as of the last regeneration, which
suggests either non-determinism in the tool or that the earlier bug had a different cause) before
committing.

Note: The license year is hardcoded to 2026, change if necessary.
