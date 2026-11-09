#!/usr/bin/env python3
"""Writes content/blueprint.json: subjects, topics, per-topic targets and the NET-Engineering paper pattern.

NET (NUST Entry Test) from NET-2025 on (nust.edu.pk "Subjects included in NET with weightings", checked 9 Nov 2026,
details in docs/research/net-research.md): every NET paper is 200 four-option MCQs in 3 hours, 1 mark each, no
negative marking. NET-Engineering is Mathematics 50 %, Physics 30 %, English 20 % (100 / 60 / 40 MCQs). NUST
publishes no topic weights: ours follow the FSc Part I/II chapters. The mocks are NET-Engineering (Homi, 9 Nov 2026);
Chemistry, Biology and Quantitative Mathematics (NET-Applied Sciences and NET-Business) are practice-only sections.
"""
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent

# section key, title, group, [(topic key, id prefix, title, items per mock paper, practice items, scope note)]
SECTIONS = [
    ("math", "Mathematics", "engineering", [
        ("numbers", "mn", "Number Systems and Complex Numbers", 6, 20, "Real numbers and their properties, rational/irrational, complex numbers: algebra, conjugate, modulus, argument, polar form, De Moivre for small powers, square roots of complex numbers, roots of unity (cube roots of unity, ω properties); sets, functions and binary operations, groups (basic)."),
        ("matrices", "mx", "Matrices and Determinants", 7, 20, "Types of matrices, addition, multiplication, transpose, symmetric/skew, determinants of 2×2 and 3×3, properties of determinants, cofactors, adjoint, inverse, singular matrices, solving linear systems (Cramer's rule, inverse method), rank basics."),
        ("quadratic", "mq", "Quadratic Equations and Partial Fractions", 8, 25, "Solving quadratics, discriminant and nature of roots, sum and product of roots, forming equations from roots, symmetric functions of roots, equations reducible to quadratic, exponential equations, radical equations, remainder and factor theorems, synthetic division; partial fractions (linear, repeated, quadratic factors)."),
        ("sequences", "ms", "Sequences and Series", 7, 20, "Arithmetic progression (nth term, sum, arithmetic means), geometric progression (nth term, sum, infinite GP), harmonic progression, relation A ≥ G ≥ H, sums of n, n², n³, word problems on AP/GP."),
        ("counting", "mc", "Permutations, Combinations and Probability", 7, 20, "Factorial notation, fundamental counting principle, permutations (including repeated and circular), combinations, nCr properties, probability of events, addition and multiplication laws, complementary, independent and mutually exclusive events, simple conditional probability."),
        ("binomial", "mb", "Mathematical Induction and Binomial Theorem", 5, 15, "Principle of mathematical induction (identifying valid statements), binomial theorem for positive integral index, general term, middle term, term independent of x, coefficients and their sums, binomial series for negative/fractional index and approximations."),
        ("trig", "mt", "Trigonometry", 14, 35, "Radian measure, arc length and sector area, trigonometric ratios of allied angles, identities, sum and difference, double and half angle, sum-to-product, periods and graphs of trigonometric functions, solution of triangles (sine, cosine, tangent rules, area, circum- and in-radius), inverse trigonometric functions, solving trigonometric equations."),
        ("functions", "mf", "Functions, Limits and Continuity", 8, 25, "Functions: domain, range, composition, inverse, even/odd, graphs and transformations; limits of algebraic, trigonometric and exponential forms (sin x/x, (1 + 1/n)ⁿ, (aˣ − 1)/x), continuity at a point, piecewise functions."),
        ("differentiation", "md", "Differentiation and its Applications", 11, 30, "Derivative from first principles, rules (sum, product, quotient, chain), implicit and parametric differentiation, derivatives of trigonometric, inverse trigonometric, exponential and logarithmic functions, higher derivatives, tangents and normals, increasing/decreasing, maxima and minima, Maclaurin series basics."),
        ("integration", "mi", "Integration", 10, 30, "Antiderivatives of standard functions, substitution, integration by parts, partial fractions in integration, definite integrals and their properties, area under a curve and between simple curves, simple differential equations (variables separable)."),
        ("lines", "ml", "Straight Lines and Linear Inequalities", 6, 20, "Distance, section formula, slope, forms of a line, angle between lines, parallel and perpendicular lines, distance from a point to a line, concurrency, area of a triangle by coordinates; linear inequalities in two variables, feasible regions, linear programming (corner points)."),
        ("conics", "mo", "Circles and Conic Sections", 6, 20, "Circle: standard and general equation, centre and radius, tangents and normals, position of a point/line; parabola, ellipse, hyperbola: standard forms, focus, directrix, vertices, eccentricity, latus rectum, axes, asymptotes."),
        ("vectors", "mv", "Vectors", 5, 15, "Vectors in 2-D and 3-D, unit vectors, direction cosines, addition, scalar (dot) product, angle between vectors, projection, vector (cross) product, area of parallelogram and triangle, scalar triple product and volume, work done by a force."),
    ]),
    ("physics", "Physics", "engineering", [
        ("measurement", "pa", "Measurements, Vectors and Equilibrium", 4, 15, "SI units, prefixes, significant figures, errors and uncertainties, dimensional analysis; vectors: resolution, addition by components, dot and cross products, torque, equilibrium conditions (first and second)."),
        ("motion", "pk", "Motion and Force", 7, 25, "Displacement, velocity, acceleration, equations of motion, velocity-time graphs, Newton's laws, momentum and impulse, conservation of momentum, elastic and inelastic collisions in one dimension, force due to water flow, rocket propulsion, projectile motion (range, height, time of flight)."),
        ("energy", "pw", "Work, Energy and Power", 4, 15, "Work by constant and variable force, power, kinetic and potential energy, work-energy principle, conservation of energy, escape velocity, interconversion of energy, efficiency."),
        ("circular", "pc", "Circular Motion, Rotation and Gravitation", 5, 20, "Angular displacement, velocity and acceleration, centripetal force, moment of inertia, angular momentum and its conservation, rotational KE, artificial satellites, orbital velocity, real and apparent weight, weightlessness, Newton's law of gravitation, variation of g."),
        ("fluids", "pf", "Fluid Dynamics", 2, 10, "Viscous drag and Stokes' law, terminal velocity, laminar and turbulent flow, equation of continuity, Bernoulli's equation and its applications (Venturi, Torricelli)."),
        ("oscillations", "po", "Oscillations", 3, 15, "Simple harmonic motion, its equations, mass-spring system, simple pendulum, energy in SHM, phase, free and forced oscillations, resonance, damping."),
        ("waves", "pv", "Waves and Sound", 4, 15, "Progressive waves, wave speed v = fλ, speed of sound (Newton and Laplace correction, temperature effect), principle of superposition, interference, beats, stationary waves on strings and in pipes (harmonics), Doppler effect."),
        ("optics", "pl", "Physical Optics and Optical Instruments", 4, 15, "Wavefronts, Huygens' principle, Young's double slit, thin films, Newton's rings, Michelson interferometer, diffraction (single slit, grating), polarisation; magnification, simple and compound microscope, telescope, resolving power, optical fibres."),
        ("thermo", "pt", "Heat and Thermodynamics", 4, 15, "Kinetic theory of gases, pressure and temperature, ideal gas law, internal energy, first law of thermodynamics, isothermal and adiabatic processes, molar specific heats, heat engines, Carnot cycle and efficiency, second law, entropy (basic)."),
        ("electrostatics", "pe", "Electrostatics and Capacitors", 6, 20, "Coulomb's law, electric field and field lines, electric flux and Gauss's law, electric potential and potential difference, electron volt, field and potential of point charges, capacitors (parallel plate, dielectrics, series and parallel, energy stored), charging and discharging (time constant)."),
        ("current", "pi", "Current Electricity", 5, 20, "Current, drift, Ohm's law, resistivity and its temperature dependence, colour code, series and parallel, electrical power, EMF and internal resistance, maximum power transfer, Kirchhoff's rules, Wheatstone bridge, potentiometer, thermistors."),
        ("magnetism", "pm", "Electromagnetism, Induction and AC", 6, 20, "Magnetic field of currents, force on a current-carrying conductor and on moving charges, e/m, galvanometer, ammeter and voltmeter conversion; Faraday's and Lenz's laws, motional EMF, self and mutual induction, energy in an inductor, generators, motors, back EMF, transformers; AC: rms values, phase, reactance, impedance in RC/RL/RLC, resonance, power in AC circuits."),
        ("electronics", "ps", "Physics of Solids and Electronics", 2, 10, "Stress, strain, Young's modulus, elastic limit, energy bands, conductors, semiconductors and insulators, p- and n-type, p-n junction, rectification, transistor basics, logic gates (AND, OR, NOT, NAND, NOR truth tables)."),
        ("modern", "pq", "Modern, Atomic and Nuclear Physics", 4, 15, "Special relativity basics (time dilation, length contraction, mass-energy), photoelectric effect, Compton effect, pair production, de Broglie waves, uncertainty principle; Bohr model, hydrogen spectrum, X-rays, lasers; nucleus, mass defect, binding energy, radioactivity, half-life, nuclear reactions, fission, fusion, radiation detectors and safety."),
    ]),
    ("english", "English", "engineering", [
        ("synonyms", "es", "Synonyms and Word Meaning", 7, 30, "Vocabulary at SAT/HSSC level: choose the word closest in meaning to a given word (stem names the word in capitals), or the meaning of a word in a short sentence context."),
        ("antonyms", "ea", "Antonyms", 5, 25, "Choose the word most opposite in meaning to a given word in capitals; distractors include synonyms and look-alike words."),
        ("analogies", "eg", "Analogies", 5, 25, "Word-pair relationships (part-whole, cause-effect, tool-user, degree, type-of, antonym pairs): stem 'A : B as' with four pair options written 'x : y'."),
        ("completion", "ec", "Sentence Completion", 8, 35, "One- or two-blank sentence completion testing vocabulary, logic and connectors (although, therefore, despite); blanks written as ______; two-blank options written 'word ... word'."),
        ("grammar", "ee", "Grammar and Error Identification", 9, 40, "Subject-verb agreement, tenses, pronouns, prepositions, articles, modifiers, parallelism, comparison, conditionals, active/passive and direct/indirect speech; identify the error (underlined parts given as (A) … (D) in the stem), choose the correct sentence, or improve the sentence."),
        ("reading", "er", "Reading Comprehension", 6, 30, "Original passages of 180-260 words (science, history, society, technology) with 3 questions each: main idea, detail, inference, vocabulary in context, author's tone or purpose."),
    ]),
    ("chemistry", "Chemistry", "applied", [
        ("stoichiometry", "ca", "Mole Concept and Stoichiometry", 0, 20, "Atoms, molecules, ions, relative masses, mole and Avogadro's number, molar volume, empirical and molecular formulae, stoichiometric calculations, limiting reactant, yield; experimental techniques (filtration, crystallisation, sublimation, solvent extraction, chromatography)."),
        ("states", "cs", "Gases, Liquids and Solids", 0, 15, "Gas laws, ideal gas equation, Dalton's and Graham's laws, kinetic theory, real gases; intermolecular forces, hydrogen bonding, vapour pressure, boiling point; crystalline solids, lattice types, unit cell basics."),
        ("atomic", "ct", "Atomic Structure", 0, 15, "Discovery of particles, Rutherford and Bohr models, hydrogen spectrum, quantum numbers, orbitals, Aufbau, Pauli, Hund's rule, electronic configurations."),
        ("bonding", "cb", "Chemical Bonding", 0, 15, "Ionic, covalent, coordinate and metallic bonds, electronegativity, polarity, VSEPR shapes, hybridisation (sp, sp², sp³), sigma and pi bonds, bond energy, dipole moment."),
        ("thermochem", "ch", "Thermochemistry", 0, 12, "Exothermic and endothermic reactions, enthalpy changes (formation, combustion, neutralisation, atomisation), Hess's law, Born-Haber cycle (basic), calorimetry."),
        ("equilibrium", "ce", "Chemical Equilibrium and Kinetics", 0, 18, "Reversible reactions, law of mass action, Kc and Kp, Le Chatelier's principle, ionic product of water, pH, buffers, solubility product, common ion effect; reaction rate, order, half-life, activation energy, catalysis."),
        ("electrochem", "cn", "Solutions and Electrochemistry", 0, 18, "Concentration units, Raoult's law, colligative properties; oxidation numbers, balancing redox, electrolysis, electrochemical cells, electrode potentials, batteries and corrosion."),
        ("periodic", "cp", "Periodic Table, s- and p-Block Elements", 0, 18, "Periodic trends (atomic radius, ionisation energy, electron affinity, electronegativity), alkali and alkaline earth metals and compounds, groups III-VII elements and their compounds, halogens, noble gases."),
        ("transition", "cx", "Transition Elements", 0, 12, "Electronic configuration, variable oxidation states, colour, magnetism, complexes and ligands, coordination number, chromate/dichromate and permanganate chemistry, iron and steel."),
        ("hydrocarbons", "co", "Organic Basics and Hydrocarbons", 0, 20, "Organic compounds, functional groups, isomerism, IUPAC naming, alkanes, alkenes, alkynes (preparation and reactions), benzene and its electrophilic substitution, reaction mechanisms basics."),
        ("halides", "cf", "Alkyl Halides, Alcohols, Phenols and Ethers", 0, 18, "Alkyl halides: SN1, SN2, E1, E2, Grignard reagents; alcohols: classification, preparation, reactions, Lucas test; phenol acidity and reactions; ethers."),
        ("carbonyl", "cc", "Aldehydes, Ketones and Carboxylic Acids", 0, 18, "Preparation and reactions of aldehydes and ketones (nucleophilic addition, Tollens' and Fehling's tests, iodoform), carboxylic acids and derivatives, esters, amides, amino acids."),
        ("macro", "cm", "Macromolecules, Industrial and Environmental Chemistry", 0, 15, "Polymers (addition and condensation), carbohydrates, proteins, lipids, nucleic acids, fertilisers, cement, paper, petrochemicals, air and water pollution, ozone depletion, green chemistry."),
    ]),
    ("biology", "Biology", "applied", [
        ("molecules", "bm", "Biological Molecules and Enzymes", 0, 20, "Water, carbohydrates, proteins, lipids, nucleic acids, conjugated molecules; enzyme structure, mechanism (lock-and-key, induced fit), factors affecting enzyme activity, inhibitors, cofactors."),
        ("cell", "bc", "Cell Structure and Function", 0, 18, "Microscopy, cell theory, plasma membrane models, cell wall, organelles (nucleus, mitochondria, plastids, ER, Golgi, lysosomes, ribosomes), prokaryotic vs eukaryotic cells."),
        ("variety", "bv", "Variety of Life: Viruses, Bacteria, Protists, Fungi", 0, 18, "Classification and five-kingdom system, binomial nomenclature, viruses (structure, lytic and lysogenic cycles, HIV, hepatitis), bacteria, cyanobacteria, protists, fungi and their importance."),
        ("plants", "bp", "Kingdom Plantae", 0, 12, "Bryophytes, tracheophytes, alternation of generations, evolution of seed habit, gymnosperms and angiosperms, families of flowering plants."),
        ("animals", "ba", "Kingdom Animalia", 0, 12, "Characteristics and classification of animal phyla (Porifera to Chordata), body symmetry, coelom, diploblastic and triploblastic organisation."),
        ("bioenergetics", "be", "Bioenergetics", 0, 15, "Photosynthesis (light and dark reactions, photosystems, factors), cellular respiration (glycolysis, Krebs cycle, electron transport chain, ATP yield), anaerobic respiration, photorespiration."),
        ("nutrition", "bn", "Nutrition, Gaseous Exchange and Transport", 0, 20, "Autotrophic and heterotrophic nutrition, human digestive system, disorders; gaseous exchange in plants and humans, respiratory disorders; transport in plants (xylem, phloem, transpiration), human heart, blood, blood vessels, lymphatic system, immunity."),
        ("homeostasis", "bh", "Homeostasis, Support and Movement", 0, 15, "Osmoregulation, excretion, nephron structure and urine formation, thermoregulation; skeleton, joints, muscle structure and sliding filament theory, plant support and movements."),
        ("coordination", "bk", "Coordination and Control", 0, 15, "Plant hormones, nervous system, neuron, nerve impulse, synapse, reflex arc, brain parts, endocrine glands and hormones, feedback mechanisms, behaviour."),
        ("reproduction", "br", "Reproduction, Growth and Development", 0, 15, "Asexual and sexual reproduction in plants and animals, human reproductive systems, menstrual cycle, sexually transmitted diseases, embryonic development, ageing, regeneration."),
        ("genetics", "bg", "Chromosomes, DNA, Cell Cycle and Genetics", 0, 22, "Chromosome structure, DNA replication, transcription, translation, genetic code, mutations; mitosis, meiosis, cell cycle control; Mendel's laws, dominance types, multiple alleles, blood groups, sex linkage, linkage and crossing over."),
        ("biotech", "bt", "Biotechnology and Evolution", 0, 13, "Recombinant DNA, restriction enzymes, vectors, PCR, gene therapy, cloning, GM organisms; theories of evolution, Darwinism, Hardy-Weinberg (basic), evidence of evolution."),
        ("ecology", "bo", "Ecosystem and Environment", 0, 15, "Ecosystem components, food chains and webs, energy flow, biogeochemical cycles, succession, biomes, population dynamics, pollution, conservation, deforestation, climate change."),
    ]),
    ("quant", "Quantitative Mathematics", "business", [
        ("arithmetic", "qa", "Arithmetic and Word Problems", 0, 40, "Percentages, ratio and proportion, averages, profit and loss, simple and compound interest, speed-distance-time, work and time, mixtures, number properties (divisibility, primes, LCM, HCF), fractions and decimals."),
        ("algebra", "qg", "Algebra and Functions", 0, 35, "Linear and quadratic equations, simultaneous equations, inequalities, exponents and logarithms, sequences, functions and graphs, word problems leading to equations."),
        ("geometry", "qm", "Geometry and Trigonometry", 0, 30, "Angles, triangles, Pythagoras, similar triangles, circles, polygons, perimeter, area and volume, coordinate geometry basics, basic trigonometric ratios and heights and distances."),
        ("matrices", "qx", "Matrices", 0, 15, "Matrix operations, determinants of 2×2 and 3×3, inverse of 2×2, solving two simultaneous equations by matrices."),
        ("statistics", "qs", "Probability and Statistics", 0, 30, "Mean, median, mode, range, standard deviation (simple), reading tables and charts, counting, permutations and combinations, basic probability."),
        ("calculus", "qc", "Limits and Basic Calculus", 0, 20, "Limits of simple functions, derivatives of polynomials, rates of change, maxima and minima in simple business contexts (profit, cost), basic integration of polynomials."),
    ]),
]

PAPERS = 20
MODES = {
    "engineering": {"title": "NET-Engineering", "subtitle": "200 questions · 3 hours · no negative marking", "minutes": 180, "questions": 200,
                    "streams": {"mock": {"title": "NET Mock", "sections": [(k, {tp[0]: tp[3] for tp in topics}) for k, _, _, topics in SECTIONS if k in ("math", "physics", "english")]}}},
}

doc = {
    "sections": [
        {"key": k, "title": t, "group": g, "topics": [
            {"key": tk, "prefix": p, "title": tt, "test": n * PAPERS, "practice": b, "scope": s} for tk, p, tt, n, b, s in topics
        ]} for k, t, g, topics in SECTIONS
    ],
    "modes": {m: {**v, "streams": {s: {"title": d["title"], "sections": [{"section": k, "quota": q} for k, q in d["sections"]]} for s, d in v["streams"].items()}} for m, v in MODES.items()},
    "papers": PAPERS,
}
want = {"math": 100, "physics": 60, "english": 40, "chemistry": 0, "biology": 0, "quant": 0}
for k, _, _, topics in SECTIONS:
    assert sum(t[3] for t in topics) == want[k], k
prefixes = [t[1] for *_, ts in SECTIONS for t in ts]
assert len(prefixes) == len(set(prefixes)), "duplicate prefix"
(ROOT / "content/blueprint.json").write_text(json.dumps(doc, indent=1, ensure_ascii=False) + "\n")
print("test", sum(t[3] for *_, ts in SECTIONS for t in ts) * PAPERS, "practice", sum(t[4] for *_, ts in SECTIONS for t in ts))
