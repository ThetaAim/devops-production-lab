# AWS Production-Like DevOps Platform

## 1️⃣ מטרת הפרויקט

מעבדת פרודקשן בענן (AWS) המדמה עבודה אמיתית של DevOps: הקמה, שבירה, ניטור, התאוששות ותיעוד תקלות.

- לא מוצר
- לא דמו
- כן סביבת Production מדומה

------

## 2️⃣ תשתית (Infrastructure as Code)

**Terraform על AWS**

- VPC (public / private)
- Subnets
- Internet Gateway / Routing
- EKS Cluster
- IAM Roles

מטרה: הקמה, מחיקה ושחזור מלאים מקוד בלבד.

------

## 3️⃣ Kubernetes Runtime

**הרצת אפליקציה על EKS**

- Deployment (אפליקציה פשוטה / Nginx)
- Service
- Ingress
- ConfigMaps / Secrets

מטרה: סביבת ריצה יציבה שאפשר “לשבור”.

------

## 4️⃣ CI/CD

**Jenkins כ־Pipeline מרכזי**

- Build Docker Image
- Push ל-ECR
- Deploy ל-EKS
- Rollback

מטרה: להמחיש פערים בין CI שעובר ל‑CD שנכשל.

------

## 5️⃣ אבטחה ורשת (DevSecOps בסיסי)

- Namespaces
- RBAC (ServiceAccounts, Roles)
- NetworkPolicies
- IAM ↔ EKS (בהמשך)

מטרה: שליטה בגישה, Least Privilege ובידוד שירותים.

------

## 6️⃣ Observability & Scaling

**ניטור ותפעול**

- Prometheus
- Grafana
- Metrics
- HPA
- Resource limits

מטרה: לזהות בעיות לפני קריסה ולהגיב אוטומטית.

------

## 7️⃣ Incident Simulation (הליבה של הפרויקט)

**תקלות מכוונות + פתרון**

- ImagePullBackOff
- Service misconfiguration
- Network isolation
- RBAC Forbidden
- OOM / עומס
- Failed rollout

כל תקלה = קובץ Incident מתועד.

------

## 8️⃣ Incident Journal (Storytelling)

**תיעוד מקצועי**

לכל Incident:

- מה נשבר
- סימפטומים
- תהליך חקירה
- פתרון
- לקחים

זה החלק שמגייס באמת קורא.

------

## 9️⃣ ניהול עלויות (בהמשך)

**FinOps בסיסי**

- זיהוי משאבים פעילים
- Scaling חכם
- כיבוי סביבות לא נחוצות

------

## 🔚 מה הפרויקט מוכיח

- הבנה מערכתית
- יכולת Debug
- עבודה תחת כאוס
- תיעוד וחשיבה מקצועית
- מוכנות לעבודה אמיתית

------

## 📌 מצב נוכחי

✔️ שלד פרויקט
➡️ עכשיו: **Terraform – VPC בסיסי**