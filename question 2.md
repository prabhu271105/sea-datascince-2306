# **Q2 – Excel Marksheet Generation & Automation using Formulas**

## **1. Introduction**
The task requires creating a complete marksheet for all students using **Excel formulas only**.  
No manual values (hardcoding) are allowed.

The marksheet includes:

- Roll Numbers (2301–2333)  
- Subjects (501–506)  
- ISA Marks  
- SEA Marks (extrapolated from ISA)  
- Total Marks  
- Percentage  
- Grade  
- Grade Points  

---

## **2. Generating Roll No and Subject Columns**

### **Roll Number (Repeats every 6 rows)**

```excel
=2300 + INT((ROW()-2)/6) + 1
```

### **Subject Code (Cycles through 501–506)**

```excel
=500 + MOD(ROW()-2, 6) + 1
```

These formulas auto-generate all **33 × 6 = 198** entries.

---

## **3. SEA Marks Calculation (ISA → SEA)**

ISA is out of 60  
SEA is out of 40

Formula:

```excel
= (ISA / 60) * 40
```

---

## **4. Total Marks**

```excel
= ISA + SEA
```

---

## **5. Percentage Calculation**

Since the total marks are out of 100:

```excel
= Total
```

OR:

```excel
= (ISA + SEA)
```

---

## **6. Grade Calculation (Using IFS)**

```excel
=IFS(
  Percentage>=85,"O",
  Percentage>=75,"A+",
  Percentage>=65,"A",
  Percentage>=55,"B+",
  Percentage>=50,"B",
  Percentage>=45,"C",
  Percentage>=40,"P",
  TRUE,"F"
)
```

---

## **7. Grade Points**

```excel
=IFS(
  Grade="O",10,
  Grade="A+",9,
  Grade="A",8,
  Grade="B+",7,
  Grade="B",6,
  Grade="C",5,
  Grade="P",4,
  TRUE,0
)
```

---

## **8. Final Output Columns**

| Column | Formula |
|-------|---------|
| Roll No | Auto-generated |
| Subject | Auto-generated |
| ISA | From Google Classroom |
| SEA | `=ISA/60*40` |
| Total | `=ISA + SEA` |
| Percentage | `=Total` |
| Grade | IFS formula |
| Grade Points | IFS formula |

---

## **9. Conclusion**
The entire marksheet was created using formulas only — no hardcoded values.  
ISA marks were used to predict SEA performance, and accurate grade assignment was completed using the given grading scheme.

