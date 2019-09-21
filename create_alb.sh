#!/bin/bash
PROFILE=$1

alb_creation_internal()
{
ENV=$1
AWS_PROFILE=$2

if [ "$#" -ne 3 ]; then
    echo "Script needs Environment, AWS PROFILE and REGION as parameters"
    echo "Allowed Region Values are |usw2|use2|"
    exit 1
fi

if [ "$3" == "usw2" ]
then
    REGION="us-west-2"
elif [ "$3" == "use2" ]
then
    REGION="us-east-2"
else
    echo "Region Incorrect"
    echo "Allowed Region Values are |usw2|use2|"
    exit 1
fi

INT_COMPONENTS=(component1 component2 component3)

for INT_COMPONENT in "${INT_COMPONENTS[@]}"; do
aws cloudformation create-stack --profile $AWS_PROFILE --region $REGION \
        --stack-name $ENV-alb-$INT_COMPONENT \
        --template-body file://./create_private_alb.json \
        --parameters file://./params.private_alb.json
done
}



alb_creation_external()
{
ENV=$1
AWS_PROFILE=$2

if [ "$#" -ne 3 ]; then
    echo "Script needs Environment, AWS PROFILE and REGION as parameters"
    echo "Allowed Region Values are |usw2|use2|"
    exit 1
fi

if [ "$3" == "usw2" ]
then
    REGION="us-west-2"
elif [ "$3" == "use2" ]
then
    REGION="us-east-2"
else
    echo "Region Incorrect"
    echo "Allowed Region Values are |usw2|use2|"
    exit 1
fi

Ext_COMPONENTS=(component1 component2 component3)

for Ext_COMPONENT in "${Ext_COMPONENTS[@]}"; do
aws cloudformation create-stack --profile $AWS_PROFILE --region $REGION \
        --stack-name $ENV-alb-$Ext_COMPONENT \
        --template-body file://./create-alb-ingress.json \
        --parameters file://./params.alb-ingress.json
done
}
##############################################################################
###################CALL alb_creation_internal For Internal ALBS###########################
##############################################################################

##############################################################################
###################CALL alb_creation_external For External ALBS#######################
##############################################################################

alb_creation_internal dev $1 usw2
alb_creation_external dev $1 usw2
