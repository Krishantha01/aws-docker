import boto3

def send_mail(message, subject):
    sns = boto3.client("sns", region_name="us-east-1")

    response = sns.publish(
        TopicArn='arn:aws:sns:us-east-1:257997452906:email-notification',
        Message=message,
        Subject=subject,
    )

    print(response)
