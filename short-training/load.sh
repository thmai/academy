DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
GRAKN=$1
KEYSPACE=$2
DATA=$DIR/data
SCRIPTS=$DIR/templates

# load ontology
date; $GRAKN/graql console -f "$DIR/schema.gql" -k $2

# load rules
date; $GRAKN/graql console -f "$DIR/rules.gql" -k $2

# load articles
date; $GRAKN/graql console -f "$DATA/articles.gql" -k $2

# load companies
date; $GRAKN/graql console -f "$DATA/companies.gql" -k $2

# load countries
date; $GRAKN/graql console -b "$DATA/countries.gql" -k $2
date; $GRAKN/graql console -b "$DATA/country-region.gql" -k $2

# load platform data
date; $GRAKN/graql migrate csv -i "$DATA/platforms.csv" -t "$SCRIPTS/platform-template.gql" -k $2

date; $GRAKN/graql migrate csv -i "$DATA/platforms.csv" -t "$SCRIPTS/platform-relations-template.gql" -k $2

# load bonds data

date; $GRAKN/graql migrate xml -i "$DATA/bonds.xml" -s "$DATA/bonds.xsd" -e bondIssuer -t "$SCRIPTS/bond-template.gql" -k $2

date
