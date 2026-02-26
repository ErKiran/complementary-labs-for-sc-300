# Complementary Labs for SC-300 (Microsoft Entra Identity & Access Administrator)

This repository contains **hands-on, scenario-style complementary labs** designed to **extend** the official Microsoft SC-300 labs with extra practice, validation steps, and audit-ready thinking.

 Use these after completing the official labs to reinforce real-world IAM operations: least privilege, RBAC, PIM, audit evidence, and troubleshooting.

---

## Official Microsoft SC-300 Labs (Reference)

Start here (official lab instructions):

- **Lab 01 – Manage User Roles**
  - Microsoft Lab Link: https://microsoftlearning.github.io/SC-300-Identity-and-Access-Administrator/Instructions/Labs/Lab_01_ManageUserRoles.html

---

## How to Use This Repo

1. Complete the **official Microsoft lab** first (link above).
2. Do the **Challenge** in this repo without looking at the solution.
3. Compare your result with the **Solution** and capture evidence (screenshots/logs).
4. Add your own notes/lessons learned (optional) to build your portfolio.

---

## Challenges & Solutions

### Challenge 1 (C-1)
- Challenge: `challenges/lab-1.md`
- Link: https://github.com/ErKiran/complementary-labs-for-sc-300/blob/main/challenges/lab-1.md

### Solution 1 (S-1)
- Solution: `solution/challenges-1/Readme.md`
- Link: https://github.com/ErKiran/complementary-labs-for-sc-300/blob/main/solution/challenges-1/Readme.md

### Challenge 2 (C-2)
- Challenge: `challenges/lab-2.md`
- Link: https://github.com/ErKiran/complementary-labs-for-sc-300/blob/main/challenges/lab-1.md

### Solution 2 (S-2)
- Solution: `solution/challenges-2/Readme.md`
- Link: https://github.com/ErKiran/complementary-labs-for-sc-300/blob/main/solution/challenges-2/Readme.md

### Challenge 5 (C-5)
- Challenge: `challenges/lab-5.md`
- Link: https://github.com/ErKiran/complementary-labs-for-sc-300/blob/main/challenges-5/lab-5.md

### Solution 5 (S-5)
- Solution: `solution/challenges-5/Readme.md`
- Link: https://github.com/ErKiran/complementary-labs-for-sc-300/blob/main/solution/challenges-5/Readme.md

---

## What You’ll Practice (SC-300 + Job Skills)

- Least privilege role selection (why not Global Admin)
- PIM concepts: **Eligible vs Active**
- Role activation, expiry, and removal
- Privilege boundary testing (negative/positive/expiry)
- Audit evidence collection (logs + screenshots + timestamps)

---

## Evidence Checklist (Recommended)

When you finish a challenge, keep:

- Ticket/notes (why access was needed)
- Screenshots:
  - Before role (access denied)
  - During activation (access granted)
  - After expiry (access denied again)
- Entra Audit logs export (CSV/JSON):
  - Role assignment / activation / removal / expiry events

---

## Contributing / Requests

If you want a new challenge topic (Conditional Access, Access Reviews, Entitlement Mgmt, External Identities, etc.), open an issue with:
- Lab reference (Microsoft link)
- Scenario goal
- Expected outcome