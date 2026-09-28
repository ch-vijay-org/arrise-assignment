# EC2 Provisioning Notes

## Requirement Coverage

Provisioned 5 EC2 instances using a single variable (`instances`)

Each instance has:
- Different instance type
- Different key pair
- Different root volume size
- Root volume configuration

Tags added:
- Name
- Environment
- Owner

Outputs:
- Instance Name -> Instance ID
- Instance Name -> Private IP

One instance uses io2 storage:
- db01

## Lifecycle Protection

The instance `db01` is protected with:

```hcl
lifecycle {
  prevent_destroy = true
}

Why db01?

Database servers typically contain critical application data. Accidental deletion can cause service outages and data loss.

Terraform will therefore block any destroy operation against db01 unless the protection is intentionally removed.
