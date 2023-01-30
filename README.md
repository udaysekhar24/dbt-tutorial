Welcome to your new dbt project!

### Dataflow
csv -> staging -> master -> dw -> mart

Note: 
1. I used seeds for importing CSV files. But, it is only advised to use seeds for referencial or MDM type of data. To import the CSV other alternative is to write custom module in Python and push data to staging tables. But, for the sake of simplicity I used seeds for importing data.
2. dw layer is not required for this data. As it is an overhead to create dim and fact tables. And there are no facts/measures in the raw data provided. But, as a standard practice dw layer is created.

### Using the starter project

Try running the following commands:
- dbt run
- dbt test



### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
