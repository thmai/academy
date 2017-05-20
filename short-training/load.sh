DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
GRAKN=$1
KEYSPACE=$2
DATA=$DIR/data
SCRIPTS=$DIR/templates

# load ontology
date; $GRAKN/bin/graql.sh -f "$DIR/ontology.gql" -k $2

# load rules
date; $GRAKN/bin/graql.sh -f "$DIR/rules.gql" -k $2

# load articles
date; $GRAKN/bin/graql.sh -f "$DATA/articles.gql" -k $2

# load companies
date; $GRAKN/bin/graql.sh -f "$DATA/companies.gql" -k $2

# load countries
date; $GRAKN/bin/graql.sh -b "$DATA/countries.gql" -k $2
date; $GRAKN/bin/graql.sh -b "$DATA/country-region.gql" -k $2

# load platform data
date; $GRAKN/bin/migration.sh csv -i "$DATA/platforms.csv" -t "$SCRIPTS/platform-template.gql" -k $2

date; $GRAKN/bin/migration.sh csv -i "$DATA/platforms.csv" -t "$SCRIPTS/platform-relations-template.gql" -k $2

# load bonds data

date; $GRAKN/bin/migration.sh xml -i "$DATA/bonds.xml" -s "$DATA/bonds.xsd" -e bondIssuer -t "$SCRIPTS/bond-template.gql" -k $2

date
