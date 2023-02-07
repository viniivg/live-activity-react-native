import React from 'react';
import {
  SafeAreaView,
  StyleSheet,
  Text,
  TouchableOpacity,
  NativeModules,
} from 'react-native';

function App(): JSX.Element {
  const {LiveActivityModule} = NativeModules;

  return (
    <SafeAreaView style={styles.container}>
      <TouchableOpacity
        style={styles.button}
        onPress={() =>
          LiveActivityModule.startNotification(
            'Burgão do Zé',
            '#02564',
            'Estamos preparando seu pedido.',
            'Em até 30 minutos seu pedido sai para entrega',
            1,
            'Já pingou aqui!',
            'cooking',
          )
        }>
        <Text style={styles.text}>Fazer pedido</Text>
      </TouchableOpacity>

      <TouchableOpacity
        style={styles.button}
        onPress={() => {
          setTimeout(() => {
            LiveActivityModule.updateNotification(
              'Já estamos levando o seu burgão.',
              'Não se esqueça de nos avaliar.',
              2,
              'Estou chegandoooo!',
              'delivery',
            );
          }, 3000);
        }}>
        <Text style={styles.text}>Sair para entrega</Text>
      </TouchableOpacity>

      <TouchableOpacity
        style={styles.button}
        onPress={() =>
          LiveActivityModule.cancelNotification(
            'Tudo pronto, agora é só aproveitar seu burgão',
            'Não se esqueça de nos avaliar.',
            3,
            'Ufaaa... Chegueiii!',
            'delivered',
          )
        }>
        <Text style={styles.text}>Pedido entregue</Text>
      </TouchableOpacity>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
  button: {
    padding: 16,
    marginTop: 12,
    justifyContent: 'center',
    alignItems: 'center',
  },
  text: {
    fontSize: 16,
    fontWeight: 'bold',
  },
});

export default App;
