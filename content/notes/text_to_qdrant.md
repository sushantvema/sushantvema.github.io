---
title: "Text-to-Qdrant: A Natural Language-first Semantic Query Layer"
date_created: 2025-06-03T09:03:24
date: 2025-06-03T09:03:26
tags:
  - resource
publish: true
---

At Influential.co, we have a humongous Qdrant vector database with two relevant
[collections](https://qdrant.tech/documentation/concepts/collections/).

- The first collection (`network_accounts`) contains one [point](https://qdrant.tech/documentation/concepts/points/?q=point) for each influencer we have across all platforms (Instagram, Facebook, Twitter, Snapchat, and Tiktok). We have almost 1 million influencers tracked since we have criteria for which influencers to track in our database.
- The second collection (`network_posts`) contains one point for each post we
  have for each influencer we have in `network_accounts`. We have nearly 1
  billion posts for all of our tracked influencers.

Each point in each collection has a unique set of attributes called a [payload](https://qdrant.tech/documentation/concepts/payload/). We use the payload

## Databricks Apps

[Databricks Apps](https://www.databricks.com/product/databricks-apps) is a
feature released in GA as of May 13th 2025.

> Databricks Apps is now generally available (GA). This feature lets you build
> and run interactive full-stack applications directly in the Databricks
> workspace. Apps run on managed infrastructure and integrate with Delta Lake,
> notebooks, ML models, and Unity Catalog. - [May 2025 Release Notes](https://www.databricks.com/product/databricks-apps)

Can build apps that run directly in Databricks environment or using external
tools/IDEs like PyCharm and VSCode.

It supports common industry-standard frameworks like Plotly Dash, Gradio, and
Streamlit. There are also prebuilt Python templates to use.

### A Production Ready Experience

Databricks Apps don't require additional custom infrastructure layers to be
built and maintained. By default they run on automatically-provisioned
serverless compute resources, allowing for seamless deployment.

Additionally, they can be developed from within Databricks workspace or your
favorite IDE.

### Built-in Governance

Granular access controls out of the box. Automatically managed service
principals for secure application-to-application communication. Automatic user
authentication using OIDC.OAuth 2.0 and SSO.

Integration with Unity Catalog speaks for itself. Inherits networking
protections of the workspace.

### Use Cases

Can have interactive dashboards, data exploration tools, customized reporting
interfaces, and much more.

> "**Common Use Cases**:
>
> - Interactive data visualizations and embedded Business Intelligence (BI) dashboards
> - Retrieval-Augmented Generation (RAG) chat apps powered by Genie
> - Custom configuration interfaces for Lakeflow
> - Data entry forms backed by Databricks SQL
> - Business process automation combining multiple Databricks services
> - Custom ops tools for alert triage and response"

### Limitations

- A Databricks workspace can host up to 50 apps.
- App files can't exceed 10 MB. If any file in the app directory exceeds this limit, deployment fails with an error.
- Databricks Apps isn't compliant with HIPAA, PCI, or FedRAMP standards.
- Databricks deletes app logs when the compute resource running the app is terminated. See [View logs for your Databricks app](https://docs.databricks.com/aws/en/dev-tools/databricks-apps/monitor).
- **If you grant consent to an app through [user authorization](https://docs.databricks.com/aws/en/dev-tools/databricks-apps/auth#user-authorization), you can't revoke that consent later.**

### Databricks Apps System Environment

- Operating System: Ubuntu 22.04 LTS
- Python environment: Python 3.11.0 in a dedicated virtual environment. All
  dependencies isolated in that environment including ones from `requirements.txt` and pre-installed libraries.
- System resources: 2 virtual CPUs and 6 GB of memory. If those are exceeded,
  Databricks might restart it.

## Resources and Experience Building a Databricks App for Text-to-Qdrant

### [Develop Databricks Apps](https://docs.databricks.com/aws/en/dev-tools/databricks-apps/app-development)

> The Databricks Apps environment automatically sets several environment
> variables, such as the URL of the Databricks workspace running the app and
> values required for authentication. Many apps also need custom configuration,
> such as a specific command to run the app or parameters for accessing a SQL
> warehouse. Use the app.yaml file to define these settings.

Workflow:

- Build and test your app in your preferred IDE
- Run the app locally at the command line and preview it in your browser
- When complete and tested, move the code and required files to Databricks
  workspace

> [!NOTE]
> I've discovered a few quirks with Developing databricks apps:
>
> 1. The sync utility is not reliable with major refactors
> 2. You have to manually add requirements.txt
> 3. They seem to use python 3.11.0 instead of 3.11.11 for some reason

### [Configure Databricks app execution with app.yaml](https://docs.databricks.com/aws/en/dev-tools/databricks-apps/app-runtime)

By default, Databricks runs the app using the command `app.py`. If the
application needs a different command-line command or entrypoint, it needs to be
defined in an `app.yaml` file, which must be located in the root of the
repository.

There are some [supported settings](https://docs.databricks.com/aws/en/dev-tools/databricks-apps/app-runtime#supported-settings) that can be configured via the app.yaml. Here are some examples for apps built with different frameworks.

Streamlit:

```yaml
command: ["streamlit", "run", "app.py"]
env:
  - name: "DATABRICKS_WAREHOUSE_ID"
    value: "quoz2bvjy8bl7skl"
  - name: "STREAMLIT_GATHER_USAGE_STATS"
    value: "false"
```

Flask:

```yaml
command:
  - gunicorn
  - app:app
  - -w
  - 4
env:
  - name: "VOLUME_URI"
    value: "/Volumes/catalog-name/schema-name/dir-name"
```

Here are examples of [defining environment variables in a Databricks app](https://docs.databricks.com/aws/en/dev-tools/databricks-apps/environment-variables). There are default ones (for example for Stramlit), and you can define custom ones.

[Manage dependencies for a Databricks app](https://docs.databricks.com/aws/en/dev-tools/databricks-apps/dependencies)

Dependencies are handled via a `requirements.txt` file defined in the root of
the repository.

> [!NOTE]
> If any listed packages match pre-installed ones, the versions in your file
> override the defaults.

Here's an example:

```txt
# Override default version of dash
dash==2.10.0

# Add additional libraries not pre-installed
requests==2.31.0
numpy==1.24.3

# Specify a compatible version range
scikit-learn>=1.2.0,<1.3.0
```

Here is a [list of pre-installed Python libraries](https://docs.databricks.com/aws/en/dev-tools/databricks-apps/dependencies#pre-installed-python-libraries)

> [!WARNING]
> Keep the following in mind when you define dependencies:
>
> - Overriding pre-installed packages may cause compatibility issues if your specified version differs significantly from the pre-installed one.
> - Always test your app to ensure that package version changes don't introduce errors.
> - Pinning explicit versions in requirements.txt helps maintain consistent app behavior across deployments (best practice)

[Add resources to a Databricks app](https://docs.databricks.com/aws/en/dev-tools/databricks-apps/resources)

As part of the Databricks consistent developer experience, Databricks Apps can
integrate with various other platform features such as Databricks SQL for
querying data, Jobs, Mosaic Model Serving, Databricks secrets, etc. These are
referred to as **_resources_** .

> "To keep apps portable and secure, avoid hardcoding resource IDs. For example,
> instead of embedding a fixed SQL warehouse ID in your app.yaml file, configure
> the SQL warehouse as a resource through the Databricks Apps UI or in
> `databricks.yaml`."

The Databricks UI for configuring resources is pretty straightforward. Here's an
example of `databricks.yaml`:

```yaml
resources:
  sql_warehouses:
    sql_warehouse: # resource key
      name: my-warehouse

  secrets:
    secret: # resource key
      scope: my-scope
      key: my-key
```

These resources can be used in the app configuration (`app.yaml`) via the
`valueFrom` field.

Example `app.yaml` snippet:

```yaml
env:
  - name: WAREHOUSE_ID
    valueFrom: sql_warehouse

  - name: SECRET_KEY
    valueFrom: secret
```

Use as usual from the app code as environment variables:

```python
import os

warehouse_id = os.getenv["WAREHOUSE_ID"]
secret_value = os.getenv["SECRET_KEY"]
```

### Pricing

Refer to this calculator: [Compute for Apps Pricing Calculator](https://www.databricks.com/product/pricing/compute-for-apps)

At Influential, we're on the Enterprise plan in US West California, on AWS.

There is a price of 50 cents per "App Capacity Hour".
