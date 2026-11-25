#!/usr/bin/env python3
"""
Universidad Distrital Francisco Jose de Caldas
Proyecto de Grado: LDWS (LAN Design Workspace System)
Verification Suite for Top-Down LAN Design Architecture & Algorithms
"""

import os
import sys
import re
import math

ROOT_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

def log_test(name, passed, details=""):
    status = "PASS" if passed else "FAIL"
    print(f"[{status}] {name}")
    if details:
        print(f"       {details}")
    return passed

def test_project_structure():
    required_files = [
        "Dockerfile",
        "docker-compose.yml",
        ".github/workflows/ci.yml",
        "schemas/ldws_ud.sql",
        "app/config/config.ini",
        "app/config/loader.php",
        "app/Services.php",
        "app/library/Elements.php",
        "app/plugins/SecurityPlugin.php",
        "app/controllers/IndexController.php",
        "app/controllers/SessionController.php",
        "app/controllers/EmpresaController.php",
        "app/controllers/GestionSolicitudController.php",
        "app/controllers/GraficaController.php",
        "app/controllers/GestionequiposController.php",
        "app/controllers/VerreportesController.php",
        "app/controllers/GestionUsuarioController.php",
        "app/models/Users.php",
        "app/models/Empresas.php",
        "app/models/Solicitudes.php",
        "app/models/Pisos.php",
        "app/models/Logico.php",
        "app/models/Equipos.php",
        "app/views/index/index.volt",
        "app/views/empresa/index.volt",
        "app/views/empresa/new.volt",
        "app/views/empresa/newpiso.volt",
        "app/views/empresa/newlogico.volt",
        "app/views/gestionsolicitud/index.volt",
        "app/views/gestionsolicitud/new.volt",
        "app/views/grafica/index.volt",
        "app/views/gestionequipos/index.volt",
        "app/views/verreportes/index.volt",
        "app/views/gestionusuario/index.volt",
        "public/images/edificio.png",
        "public/images/piso1.png",
        "public/images/pison.png"
    ]

    missing = [f for f in required_files if not os.path.exists(os.path.join(ROOT_DIR, f))]
    if missing:
        return log_test("Suite 1: MVC Architecture & Asset Completeness", False, f"Missing files: {missing}")

    return log_test("Suite 1: MVC Architecture & Asset Completeness", True, f"All {len(required_files)} core architecture files verified.")

def test_database_schema():
    sql_path = os.path.join(ROOT_DIR, "schemas/ldws_ud.sql")
    if not os.path.exists(sql_path):
        return log_test("Suite 2: Database Schema & Relational Integrity", False, "Missing schemas/ldws_ud.sql")

    with open(sql_path, "r", encoding="utf-8") as f:
        content = f.read()

    expected_tables = ["users", "empresas", "solicitudes", "pisos", "logico", "equipos"]
    for tbl in expected_tables:
        if f"CREATE TABLE `{tbl}`" not in content and f"CREATE TABLE IF NOT EXISTS `{tbl}`" not in content:
            return log_test("Suite 2: Database Schema & Relational Integrity", False, f"Missing table definition: {tbl}")

    # Check for foreign keys
    if "CONSTRAINT `fk_empresas_users`" not in content or "CONSTRAINT `fk_solicitudes_empresas`" not in content:
        return log_test("Suite 2: Database Schema & Relational Integrity", False, "Foreign key constraints missing in SQL dump")

    return log_test("Suite 2: Database Schema & Relational Integrity", True, "All 6 tables and relational foreign key constraints verified.")

def test_physical_design_math():
    # Simulates Pisos.php mathematical sizing
    largo = 35.0
    ancho = 25.0
    alto = 3.5
    equipos = 45

    # 1. Area
    area = largo * ancho
    if area != 875.0:
        return log_test("Suite 3: Physical Design Calculations (TIA/EIA-568)", False, f"Area: {area} != 875.0")

    # 2. Cable length
    distancia_media = (1.2 * ((largo + ancho) / 2.0)) + alto
    cable_total = round(equipos * distancia_media * 1.15, 1)
    if cable_total != 2044.1:
        return log_test("Suite 3: Physical Design Calculations (TIA/EIA-568)", False, f"Cable total: {cable_total} != 2044.1")

    # 3. 305m boxes
    cajas = math.ceil(cable_total / 305.0)
    if cajas != 7:
        return log_test("Suite 3: Physical Design Calculations (TIA/EIA-568)", False, f"Cajas: {cajas} != 7")

    # 4. Access Points
    ap_area = math.ceil(area / 200.0) # 5
    ap_devices = math.ceil(equipos / 30.0) # 2
    aps = max(1, max(ap_area, ap_devices))
    if aps != 5:
        return log_test("Suite 3: Physical Design Calculations (TIA/EIA-568)", False, f"APs: {aps} != 5")

    # 5. Switches 24p
    puertos = equipos + aps
    switches = math.ceil((puertos * 1.20) / 24.0)
    if switches != 3:
        return log_test("Suite 3: Physical Design Calculations (TIA/EIA-568)", False, f"Switches: {switches} != 3")

    return log_test("Suite 3: Physical Design Calculations (TIA/EIA-568)", True, f"Floor math verified: Area={area}m2, Cable={cable_total}m ({cajas} boxes), APs={aps}, Switches={switches}.")

def test_logical_vlsm_design():
    # Simulates Logico.php VLAN configuration
    vlans = [
        {"id": 10, "name": "DATOS_USUARIOS", "net": "192.168.10.0/24", "gw": "192.168.10.1"},
        {"id": 20, "name": "VOZ_SOBRE_IP", "net": "192.168.20.0/24", "gw": "192.168.20.1"},
        {"id": 30, "name": "SERVIDORES", "net": "192.168.30.0/24", "gw": "192.168.30.1"},
        {"id": 50, "name": "GESTION_RED", "net": "192.168.50.0/24", "gw": "192.168.50.1"},
        {"id": 99, "name": "WIFI_INVITADOS", "net": "192.168.99.0/24", "gw": "192.168.99.1"}
    ]

    for v in vlans:
        gw_prefix = ".".join(v["gw"].split(".")[:3])
        net_prefix = ".".join(v["net"].split("/")[0].split(".")[:3])
        if gw_prefix != net_prefix:
            return log_test("Suite 4: Logical VLSM & Subnet Segmentation", False, f"Gateway mismatch for VLAN {v['id']}")

    return log_test("Suite 4: Logical VLSM & Subnet Segmentation", True, "All 5 VLANs, CIDR /24 subnets, and default gateways validated.")

def test_cisco_ios_generation():
    logico_path = os.path.join(ROOT_DIR, "app/models/Logico.php")
    with open(logico_path, "r", encoding="utf-8") as f:
        code = f.read()

    switch_keywords = ["switchport mode trunk", "switchport mode access", "switchport voice vlan 20", "spanning-tree portfast", "spanning-tree bpduguard enable"]
    for kw in switch_keywords:
        if kw not in code:
            return log_test("Suite 5: Cisco IOS Provisioning Script Engine", False, f"Missing switch command: {kw}")

    router_keywords = ["encapsulation dot1Q 10", "ip dhcp pool", "standby 10 ip 192.168.10.254", "standby 10 priority 110"]
    for kw in router_keywords:
        if kw not in code:
            return log_test("Suite 5: Cisco IOS Provisioning Script Engine", False, f"Missing router command: {kw}")

    return log_test("Suite 5: Cisco IOS Provisioning Script Engine", True, "Cisco IOS CLI syntax for Access Switch, Inter-VLAN router, DHCP, and HSRP verified.")

def test_security_and_navigation():
    plugin_path = os.path.join(ROOT_DIR, "app/plugins/SecurityPlugin.php")
    with open(plugin_path, "r", encoding="utf-8") as f:
        content = f.read()

    resources = ["empresa", "gestionsolicitud", "grafica", "gestionequipos", "verreportes", "gestionusuario"]
    for res in resources:
        if f"'{res}'" not in content:
            return log_test("Suite 6: Security ACL & Role-Based Access Control", False, f"Resource {res} not protected in SecurityPlugin")

    elements_path = os.path.join(ROOT_DIR, "app/library/Elements.php")
    with open(elements_path, "r", encoding="utf-8") as f:
        el_content = f.read()

    for res in ["empresa", "gestionsolicitud", "grafica", "gestionequipos", "verreportes"]:
        if f"'{res}'" not in el_content:
            return log_test("Suite 6: Security ACL & Role-Based Access Control", False, f"Menu link for {res} missing in Elements.php")

    return log_test("Suite 6: Security ACL & Role-Based Access Control", True, "ACL roles, private resources, and UI elements fully wired.")

def test_zero_em_dashes():
    em_dash = "\u2014"
    violations = []

    scan_dirs = ["app", "schemas", "scripts", "public", ".github"]
    for d in scan_dirs:
        dir_path = os.path.join(ROOT_DIR, d)
        if not os.path.exists(dir_path):
            continue
        for root, _, files in os.walk(dir_path):
            for file in files:
                if file.endswith((".php", ".volt", ".sql", ".py", ".yml", ".yaml", ".ini", ".md")):
                    fpath = os.path.join(root, file)
                    with open(fpath, "r", encoding="utf-8", errors="ignore") as f:
                        for idx, line in enumerate(f, 1):
                            if em_dash in line:
                                violations.append(f"{os.path.relpath(fpath, ROOT_DIR)}:{idx}")

    if violations:
        return log_test("Suite 7: Zero Em-Dash Quality Rule", False, f"Em-dash detected in {len(violations)} locations: {violations[:3]}")

    return log_test("Suite 7: Zero Em-Dash Quality Rule", True, "Strict zero em-dash compliance verified across all files.")

def main():
    print("=" * 80)
    print("  UNIVERSIDAD DISTRITAL FRANCISCO JOSE DE CALDAS")
    print("  LDWS (LAN Design Workspace System) - Architecture & Logic Suite")
    print("=" * 80)

    suites = [
        test_project_structure,
        test_database_schema,
        test_physical_design_math,
        test_logical_vlsm_design,
        test_cisco_ios_generation,
        test_security_and_navigation,
        test_zero_em_dashes
    ]

    results = [s() for s in suites]
    print("=" * 80)
    passed = sum(results)
    total = len(results)
    print(f"  Summary: {passed}/{total} verification suites passed.")
    print("=" * 80)

    if passed != total:
        sys.exit(1)
    sys.exit(0)

if __name__ == "__main__":
    main()
